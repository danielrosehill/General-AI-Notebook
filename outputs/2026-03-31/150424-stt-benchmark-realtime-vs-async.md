# STT Benchmarking: Real-Time vs Async Inference & AMD GPU Considerations

**Prompt source**: `inline (command line)`
**Executed**: 2026-03-31 15:04:24 IST
**Related prompt**: [[20260331-150424-stt-benchmark-realtime-vs-async]]

---

## Can All STT Models Run in Both Modes?

**No — the model architecture determines which modes it supports.**

### Three categories:

| Category | Real-Time (Streaming) | Async (Full File) | Examples |
|----------|----------------------|-------------------|----------|
| **Streaming-native** | Yes | Yes (trivially) | Moonshine, Silero, DeepSpeech, Vosk, Conformer-Transducer models |
| **Offline/batch-only** | No (not without chunking hacks) | Yes | Whisper (all sizes), Canary, Parakeet-CTC/RNNT |
| **Both modes supported** | Yes | Yes | NVIDIA Canary (with streaming export), Faster-Whisper (with VAD chunking), Whisper-Streaming wrappers |

### Why the distinction matters:

- **Streaming models** use architectures like CTC, RNN-Transducer, or Conformer-Transducer that process audio incrementally — they emit tokens as audio arrives.
- **Encoder-decoder models** (like Whisper) need the full utterance (or a fixed-length chunk) before they can decode. You can *simulate* streaming by chunking audio into segments (e.g., 5-second windows with overlap), but this isn't true streaming — it adds latency and can degrade accuracy at chunk boundaries.
- For a **fair benchmark**, you should compare models within category, or explicitly note when you're comparing a model in its native mode vs a chunked/simulated mode.

### What to benchmark:

| Metric | Real-Time | Async |
|--------|-----------|-------|
| **Latency** | Time-to-first-token, end-to-end latency per utterance | Total processing time for full file |
| **Accuracy** | WER on streaming output | WER on final transcript |
| **Throughput** | Real-time factor (RTF) — ratio of processing time to audio duration | Same, but for batch processing |
| **GPU utilization** | Typically lower (waiting for audio) | Can be very high (full batching) |

## AMD GPU: Inference Engines

**Yes, you will likely need different inference engines** depending on the model, because ROCm support varies.

### Your setup: RX 7700 XT (gfx1101, RDNA 3, ROCm)

| Engine | ROCm/AMD Support | Best For | Notes |
|--------|-------------------|----------|-------|
| **PyTorch + ROCm** | Good (official) | Whisper, HuggingFace models, most research models | Your primary engine. `torch.device("hip")` or `"cuda"` (ROCm maps CUDA calls). Works for Whisper, Faster-Whisper (via CTranslate2), NeMo models. |
| **CTranslate2** | Partial | Faster-Whisper | Has ROCm builds but can be finicky on RDNA 3. Worth testing — when it works, it's significantly faster than vanilla PyTorch Whisper. |
| **ONNX Runtime** | Good (ROCm EP) | Silero, Moonshine, exported models | `onnxruntime-rocm` package. Good for models that ship ONNX exports. Silero runs great here. |
| **Whisper.cpp (hipBLAS)** | Works | Whisper (all sizes) | C++ engine, compiles with hipBLAS for AMD. Very fast, low memory. Good for benchmarking Whisper specifically. Build with `-DGGML_HIP=ON`. |
| **Vosk / Kaldi** | CPU-only typically | Vosk models | Doesn't benefit from GPU. Include as a CPU baseline. |
| **NeMo** | Via PyTorch ROCm | Canary, Parakeet, Conformer | NVIDIA's toolkit but runs on ROCm through PyTorch. Some custom CUDA kernels may not work — test before committing. |

### Practical recommendation for your benchmark:

1. **Primary engine**: PyTorch with ROCm — covers the most models
2. **Whisper specifically**: Also test with `whisper.cpp` (hipBLAS) — it's often 3-5x faster than PyTorch Whisper and gives you a fairer "best case" for Whisper
3. **Streaming models**: ONNX Runtime with ROCm EP for Silero/Moonshine; PyTorch ROCm for Conformer-based models
4. **CPU baseline**: Include at least one CPU-only run (Vosk or Whisper.cpp CPU) for comparison

### Engine differences will affect your benchmark:

This is important — **the same model can perform very differently across engines**. Whisper on PyTorch vs whisper.cpp vs CTranslate2 can show 2-5x throughput differences. You should either:

- **Pick one engine per model** (whichever is "best" for that model on your hardware) and note it
- **Or benchmark the same model across engines** as a separate axis

The first approach answers "which STT model is best on my machine?" The second answers "which engine is best for model X on AMD?"

## Summary

- Not all models support both modes — architecture matters
- On AMD/ROCm you'll need 2-3 engines minimum (PyTorch ROCm, whisper.cpp hipBLAS, ONNX Runtime ROCm)
- The engine choice significantly affects results, so document it as part of your benchmark methodology

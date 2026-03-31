# STT Model Comparison Table

**Prompt source**: `inline (command line)`
**Executed**: 2026-03-31 15:19:24 IST
**Related prompt**: [[20260331-151924-stt-model-comparison-table]]
**Prior context**: [[150424-stt-benchmark-realtime-vs-async]], [[150908-stt-models-realtime-vs-batch]]
**Data file**: [[stt-models.csv|tables/stt-models.csv]]

---

## Open Source Models

| Model | Manufacturer | Params | Architecture | Real-Time | Streaming | Batch | Inference Engine (AMD) | ROCm Support | Languages | License |
|-------|-------------|--------|-------------|-----------|-----------|-------|----------------------|-------------|-----------|---------|
| Whisper tiny | OpenAI | 39M | Enc-dec Transformer | No | No* | Yes | PyTorch ROCm, whisper.cpp (hipBLAS) | Yes | 99 | MIT |
| Whisper base | OpenAI | 74M | Enc-dec Transformer | No | No* | Yes | PyTorch ROCm, whisper.cpp (hipBLAS) | Yes | 99 | MIT |
| Whisper small | OpenAI | 244M | Enc-dec Transformer | No | No* | Yes | PyTorch ROCm, whisper.cpp (hipBLAS) | Yes | 99 | MIT |
| Whisper medium | OpenAI | 769M | Enc-dec Transformer | No | No* | Yes | PyTorch ROCm, whisper.cpp (hipBLAS) | Yes | 99 | MIT |
| Whisper large-v3 | OpenAI | 1.55B | Enc-dec Transformer | No | No* | Yes | PyTorch ROCm, whisper.cpp (hipBLAS) | Yes | 99 | MIT |
| Whisper large-v3-turbo | OpenAI | 809M | Enc-dec Transformer | No | No* | Yes | PyTorch ROCm, whisper.cpp (hipBLAS) | Yes | 99 | MIT |
| Faster-Whisper (large-v3) | Systran/Community | 1.55B | CTranslate2 enc-dec | No | Simulated (VAD) | Yes | CTranslate2 (ROCm partial) | Partial | 99 | MIT |
| Distil-Whisper large-v3 | HuggingFace | 756M | Distilled enc-dec | No | No* | Yes | PyTorch ROCm | Yes | EN + multi | MIT |
| Moonshine tiny | Useful Sensors | 27M | Enc-dec (stream-opt) | **Yes** | **Yes** | Yes | ONNX Runtime ROCm, PyTorch ROCm | Yes | EN | MIT |
| Moonshine base | Useful Sensors | 61M | Enc-dec (stream-opt) | **Yes** | **Yes** | Yes | ONNX Runtime ROCm, PyTorch ROCm | Yes | EN | MIT |
| Silero STT | Silero AI | ~18M | Custom CTC | **Yes** | **Yes** | Yes | ONNX Runtime ROCm | Yes | EN/DE/ES/UK | MIT |
| Vosk | Alpha Cephei | 50M–1.8B | Kaldi HMM/CTC | **Yes** | **Yes** | Yes | CPU only (Kaldi) | No | 20+ | Apache 2.0 |
| DeepSpeech | Mozilla | ~47M | CTC + RNN | **Yes** | **Yes** | Yes | CPU / TF (no ROCm) | No | EN | MPL 2.0 |
| Conformer-Transducer | NVIDIA (NeMo) | ~120M | Conformer-RNNT | **Yes** | **Yes** | Yes | PyTorch ROCm (NeMo) | Yes* | EN + multi | Apache 2.0 |
| FastConformer-Transducer | NVIDIA (NeMo) | ~114M | FastConformer-RNNT | **Yes** | **Yes** | Yes | PyTorch ROCm (NeMo) | Yes* | EN + multi | Apache 2.0 |
| Parakeet-RNNT 1.1B | NVIDIA (NeMo) | 1.1B | FastConformer-Trans | **Yes** | **Yes** | Yes | PyTorch ROCm (NeMo) | Yes* | EN | CC-BY-4.0 |
| Parakeet-CTC 1.1B | NVIDIA (NeMo) | 1.1B | FastConformer-CTC | No | No | Yes | PyTorch ROCm (NeMo) | Yes* | EN | CC-BY-4.0 |
| Canary-1B | NVIDIA (NeMo) | 1B | Multi-task enc-dec | No | No | Yes | PyTorch ROCm (NeMo) | Yes* | EN + multi | Apache 2.0 |
| WeNet | WeNet Community | 80–120M | Conformer U2 | **Yes** | **Yes (dual)** | Yes | PyTorch ROCm, ONNX RT ROCm | Yes | ZH/EN/multi | Apache 2.0 |
| Zipformer | k2-fsa / Icefall | ~65M | Zipformer-Trans | **Yes** | **Yes** | Yes | PyTorch ROCm | Yes | EN + multi | Apache 2.0 |
| SpeechBrain Trans | SpeechBrain | Varies | RNNT/Transducer | **Yes** | **Yes** | Yes | PyTorch ROCm | Yes | EN + multi | Apache 2.0 |
| Wav2Letter++ | Meta | ~100M | CTC | **Yes** | **Yes** | Yes | CPU / custom C++ | No | EN | BSD |
| Wav2Vec 2.0 | Meta | 315M–1B | CTC (fine-tuned) | No | No | Yes | PyTorch ROCm | Yes | Multi | MIT |
| HuBERT | Meta | 316M–964M | CTC (fine-tuned) | No | No | Yes | PyTorch ROCm | Yes | EN + multi | MIT |
| MMS | Meta | 1B | CTC / Wav2Vec2 | No | No | Yes | PyTorch ROCm | Yes | 1100+ | CC-BY-NC |
| SeamlessM4T v2 | Meta | 2.3B | Enc-dec | No | No | Yes | PyTorch ROCm | Yes | 100+ | CC-BY-NC |
| Qwen2-Audio | Alibaba | ~8B | Multimodal LLM | No | No | Yes | PyTorch ROCm | Yes | Multi | Apache 2.0 |

\* Whisper/Distil-Whisper: "No" for native streaming; can be simulated with audio chunking but with accuracy loss at boundaries.
\* NVIDIA NeMo models: ROCm works via PyTorch but some custom CUDA kernels may need patching for full compatibility.

## SaaS Models

| Service | Model | Real-Time | Streaming | Batch | Latency | Languages | Pricing Model |
|---------|-------|-----------|-----------|-------|---------|-----------|---------------|
| Deepgram | Nova-3 | **Yes** | **WebSocket** | Yes (pre-recorded) | ~100–300ms | 50+ | Per-audio-hour |
| Deepgram | Nova-2 | **Yes** | **WebSocket** | Yes (pre-recorded) | ~100–300ms | 36+ | Per-audio-hour |
| AssemblyAI | Universal-2 | **Yes (EN)** | **WebSocket** | Yes | ~200–400ms | 20+ | Per-audio-hour |
| Google Cloud | Chirp 2 | **Yes** | **gRPC stream** | Yes (long-running) | ~100–300ms | 125+ | Per-15s-interval |
| Azure | Custom Neural | **Yes** | **SDK stream** | Yes (batch) | ~100–200ms | 100+ | Per-audio-hour |
| AWS | Transcribe | **Yes** | **WebSocket/HTTP2** | Yes (async jobs) | ~200–500ms | 100+ | Per-second |
| Speechmatics | Ursa 2 | **Yes** | **WebSocket** | Yes | ~200–400ms | 50+ | Per-audio-hour |
| Rev AI | Custom | **Yes** | **WebSocket** | Yes | ~200–400ms | Multi | Per-audio-hour |
| Picovoice | Cheetah | **Yes** | **Native SDK** | No | <100ms | EN | Per-device |
| Picovoice | Leopard | No | No | Yes | N/A | EN | Per-device |
| Gladia | Enhanced Whisper | **Yes** | **WebSocket** | Yes | ~200–500ms | 100+ | Per-audio-hour |
| OpenAI | Whisper API | No | No | Yes (25MB) | N/A | 57 | Per-audio-minute |

## AMD GPU Quick Reference

For the RX 7700 XT (RDNA 3, gfx1101, ROCm):

| Engine | Install | Best For | AMD Status |
|--------|---------|----------|------------|
| **PyTorch ROCm** | `pip install torch --index-url https://download.pytorch.org/whl/rocm6.2` | Most models | Official support |
| **whisper.cpp (hipBLAS)** | Build with `-DGGML_HIP=ON` | Whisper variants | Works well |
| **ONNX Runtime ROCm** | `pip install onnxruntime-rocm` | Silero, Moonshine, exported models | Official support |
| **CTranslate2 ROCm** | Build from source with ROCm | Faster-Whisper | Community builds, RDNA3 can be flaky |
| **CPU fallback** | Any | Vosk, DeepSpeech, Wav2Letter++ | Always works |

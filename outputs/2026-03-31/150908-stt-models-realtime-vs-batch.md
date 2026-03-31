# STT Models: Real-Time vs Batch — Open Source & SaaS

**Prompt source**: `inline (command line)`
**Executed**: 2026-03-31 15:09:08 IST
**Related prompt**: [[20260331-150908-stt-models-realtime-vs-batch]]
**Prior context**: [[150424-stt-benchmark-realtime-vs-async]] — STT benchmarking methodology for real-time vs async inference on AMD GPU

---

## Streaming-Native Models (Designed for Real-Time)

These use architectures (CTC, RNN-Transducer, Conformer-Transducer) that emit tokens incrementally as audio arrives.

### Open Source

| Model | Architecture | Languages | Notes |
|-------|-------------|-----------|-------|
| **Moonshine** (Useful Sensors) | Encoder-decoder, optimized for streaming | English | Tiny (~30MB) and base (~60MB) variants. Designed for on-device real-time. Very fast on CPU. |
| **Silero STT** | Custom CTC-based | English, German, Spanish, Ukrainian | ONNX models, extremely lightweight. Great latency. |
| **Vosk** (Alpha Cephei) | Kaldi-based, CTC/HMM | 20+ languages | Offline-capable, lightweight. True streaming API. CPU-friendly. |
| **DeepSpeech** (Mozilla) | CTC + RNN | English (community models for others) | Deprecated but still usable. True streaming. |
| **NVIDIA Conformer-Transducer** (NeMo) | Conformer-Transducer (RNNT) | English, multilingual | State-of-the-art streaming accuracy. Requires NeMo toolkit. Models on HuggingFace. |
| **NVIDIA FastConformer-Transducer** (NeMo) | FastConformer-RNNT | English, multilingual | Faster variant of above, optimized for streaming. |
| **NVIDIA Parakeet-RNNT** (NeMo) | FastConformer-Transducer | English | Streaming-capable variant of Parakeet. High accuracy English model. Note: the Parakeet-CTC variant is batch-only — see batch section. |
| **WeNet** | Conformer/U2 (unified streaming + non-streaming) | Chinese, English, multilingual | Can run in both modes natively. Strong CTC/attention hybrid. |
| **Zipformer** (Icefall/k2) | Zipformer-Transducer | English, multilingual | Next-gen from the Kaldi team. Excellent streaming WER. |
| **SpeechBrain Transducer** | RNNT/Transducer | English, multilingual | Research-grade streaming models via SpeechBrain toolkit. |
| **Wav2Letter++** (Meta) | CTC | English | Fast, C++ inference. Designed for real-time. Older but efficient. |

### SaaS (Streaming APIs)

| Service | Model(s) | Languages | Latency | Notes |
|---------|----------|-----------|---------|-------|
| **Deepgram Nova-3** | Nova-3 | 50+ languages | ~100-300ms | Purpose-built for real-time. WebSocket API. Best-in-class streaming accuracy. |
| **Deepgram Nova-2** | Nova-2 | 36+ languages | ~100-300ms | Previous gen, still excellent. |
| **AssemblyAI Real-Time** | Universal-2 | English (streaming), 20+ (batch) | ~200-400ms | WebSocket streaming. Real-time mode is English-focused. |
| **Google Cloud STT v2** | Chirp 2, Chirp | 125+ languages | ~100-300ms | Streaming RecognizeStream API. Chirp 2 is their latest. |
| **Azure Speech Service** | Custom Neural Voice / Whisper | 100+ languages | ~100-200ms | SDK-based streaming. Very mature. |
| **AWS Transcribe Streaming** | Proprietary | 30+ languages | ~200-500ms | WebSocket/HTTP2 streaming. Medical variant available. |
| **Rev AI** | Custom | English, multilingual | ~200-400ms | WebSocket streaming API. |
| **Speechmatics** | Ursa 2 | 50+ languages | ~200-400ms | Real-time WebSocket. Strong multilingual. |
| **Picovoice Cheetah** | Cheetah | English | <100ms | On-device streaming, very low latency. Edge-first. |
| **Picovoice Leopard** | Leopard | English | N/A (batch) | Same company, but this one is batch — included for contrast. |
| **Gladia** | Whisper-based + proprietary | 100+ languages | ~200-500ms | WebSocket real-time API. Wraps enhanced Whisper with streaming layer. |

---

## Batch/Offline-Native Models (Designed for Full-File Processing)

These use encoder-decoder architectures that process complete utterances or long audio segments.

### Open Source

| Model | Architecture | Languages | Notes |
|-------|-------------|-----------|-------|
| **Whisper** (OpenAI) | Encoder-decoder (Transformer) | 99 languages | The benchmark standard. Batch-only natively. Tiny through Large-v3-turbo. |
| **Faster-Whisper** | CTranslate2-optimized Whisper | 99 languages | 4-8x faster than vanilla Whisper. Still batch, but VAD-based chunking can simulate streaming. |
| **Whisper.cpp** | GGML Whisper port | 99 languages | C++ port, runs on CPU/GPU. Batch, but has experimental real-time mode with chunking. |
| **Distil-Whisper** (HuggingFace) | Distilled Whisper | English, multilingual | 6x faster, 49% smaller than Whisper Large-v3. Batch. |
| **NVIDIA Canary** (NeMo) | Multi-task encoder-decoder | English, multilingual | High accuracy. Primarily batch. Can be exported for streaming with some work. |
| **NVIDIA Parakeet-CTC** (NeMo) | FastConformer-CTC | English | Batch-only variant. High accuracy English ASR. The RNNT variant is streaming-capable — see streaming section. |
| **SeamlessM4T** (Meta) | Encoder-decoder, multimodal | 100+ languages | Translation + transcription. Batch-oriented. |
| **MMS** (Meta) | CTC/Wav2Vec2 | 1100+ languages | Massive language coverage. CTC-based so technically could stream, but designed for batch. |
| **Wav2Vec 2.0** (Meta) | CTC fine-tuned | Multilingual | Self-supervised pretraining + CTC head. Batch-focused. |
| **HuBERT** (Meta) | CTC fine-tuned | English, multilingual | Similar to Wav2Vec 2.0. Research-oriented. |
| **Qwen-Audio / Qwen2-Audio** (Alibaba) | Multimodal LLM | Multilingual | LLM-based, batch only. High accuracy but slow. |
| **Gemini** (Google) | Multimodal LLM | Multilingual | Can transcribe audio via multimodal input. Batch, API-only. |

### SaaS (Batch/Async APIs)

| Service | Model(s) | Languages | Notes |
|---------|----------|-----------|-------|
| **AssemblyAI** | Universal-2 | 20+ languages | Batch API with rich features (speaker diarization, summarization, sentiment). |
| **Deepgram Pre-Recorded** | Nova-3 | 50+ languages | Same models as streaming, but batch endpoint for file uploads. |
| **Google Cloud STT (batch)** | Chirp 2 | 125+ languages | Long-running recognition for files. |
| **Azure Batch Transcription** | Whisper, Custom Neural | 100+ languages | Upload files, get results asynchronously. |
| **AWS Transcribe** | Proprietary | 100+ languages | Async job API for file transcription. |
| **OpenAI Whisper API** | Whisper Large-v2 | 57 languages | File upload, batch only. 25MB limit. |

---

## Dual-Mode Models (Natively Support Both)

These are specifically designed or exported to work in either mode without hacks.

| Model | Streaming Mode | Batch Mode | Notes |
|-------|---------------|------------|-------|
| **WeNet** | U2 unified streaming/non-streaming | Full attention | Single model, two decoding paths. |
| **NVIDIA Parakeet-RNNT** | Transducer streaming | Full-context | RNNT variant streams; CTC variant is batch-only. |
| **NVIDIA FastConformer Hybrid** | Transducer path | CTC/Attention path | NeMo hybrid models export to both modes. |
| **Zipformer (k2/Icefall)** | Transducer streaming | Full-context re-score | Designed for both from the start. |
| **Deepgram Nova-3** (SaaS) | WebSocket streaming | Pre-recorded API | Same model, two API endpoints. |
| **Google Chirp 2** (SaaS) | StreamingRecognize | LongRunningRecognize | Same model, two gRPC methods. |
| **Azure Speech** (SaaS) | SDK streaming | Batch transcription | Same underlying models. |

---

## Key Takeaway for Benchmarking

For a fair benchmark on your AMD setup (per the [[150424-stt-benchmark-realtime-vs-async|previous research]]):

- **Streaming category**: Moonshine, Silero, Zipformer, NVIDIA Conformer-Transducer (open source) vs Deepgram Nova-3, Google Chirp 2 (SaaS)
- **Batch category**: Whisper Large-v3-turbo, Faster-Whisper, Distil-Whisper, Canary (open source) vs AssemblyAI Universal-2, OpenAI Whisper API (SaaS)
- **Dual-mode**: WeNet and Parakeet-RNNT are the best candidates for comparing the same model across both modes

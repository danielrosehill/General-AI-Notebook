Run all pending prompts in the queue.

For each file in `prompts/to-run/`:

1. **Read/transcribe**: Text files (`.txt`, `.md`) — read directly. Audio files (`.mp3`, `.wav`, `.ogg`, `.m4a`, `.webm`) — transcribe the audio content first.
2. **Execute**: Carry out whatever the prompt asks.
3. **Save output** to `outputs/YYYY-MM-DD/HHMMSS-<slug>.md` using IST timezone. The `<slug>` is a short kebab-case summary of the prompt (max 50 chars). Use this format:

```markdown
# <Brief title>

**Prompt source**: `<original filename>`
**Executed**: YYYY-MM-DD HH:MM:SS IST

---

<output content>
```

4. **Move** the prompt file from `prompts/to-run/` to `prompts/run/`.
5. After all prompts are processed, **commit and push** all changes.

If there are no files in `prompts/to-run/`, report that the queue is empty.

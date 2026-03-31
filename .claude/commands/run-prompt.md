Run a single prompt file from the queue.

Arguments: $ARGUMENTS (the filename to run from `prompts/to-run/`)

1. Find the file `prompts/to-run/$ARGUMENTS`. If not found, list available files and ask the user to pick one.
2. **Read/transcribe**: Text files — read directly. Audio files — transcribe the audio content first.
3. **Execute**: Carry out whatever the prompt asks.
4. **Save output** to `outputs/YYYY-MM-DD/HHMMSS-<slug>.md` using IST timezone. The `<slug>` is a short kebab-case summary of the prompt (max 50 chars). Use this format:

```markdown
# <Brief title>

**Prompt source**: `<original filename>`
**Executed**: YYYY-MM-DD HH:MM:SS IST

---

<output content>
```

5. **Move** the prompt file from `prompts/to-run/` to `prompts/run/`.
6. **Commit and push** the changes.

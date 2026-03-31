# General AI Notebook

## Purpose

This is a prompt execution workspace. Daniel places prompts (text files or audio files) in the `prompts/` directory, and Claude runs them and saves outputs with timestamps.

## Directory Structure

```
prompts/
  to-run/       # Queue: place prompt files here to be executed
  run/           # Archive: prompts move here after execution
  audio.md       # Notes on audio prompt handling
outputs/         # All prompt outputs saved here with timestamps
```

## Prompt File Formats

- **Text prompts**: `.txt` or `.md` files containing the prompt text
- **Audio prompts**: `.mp3`, `.wav`, `.ogg`, `.m4a`, `.webm` files — transcribe first, then execute the transcribed prompt

## Slash Commands

### `/run-prompts`

Run all prompts currently in `prompts/to-run/`. For each file:

1. **Read/transcribe** the prompt (text files: read directly; audio files: transcribe the content)
2. **Execute** the prompt — carry out whatever the prompt asks
3. **Save output** to `outputs/YYYY-MM-DD/HHMMSS-<slug>.md` where `<slug>` is a short kebab-case summary of the prompt (max 50 chars)
4. **Move** the prompt file from `prompts/to-run/` to `prompts/run/`

Output file format:
```markdown
# <Brief title summarizing the prompt>

**Prompt source**: `<original filename>`
**Executed**: YYYY-MM-DD HH:MM:SS IST

---

<output content>
```

### `/run-prompt <filename>`

Run a single specific prompt file from `prompts/to-run/`. Same process as above but for one file only.

### `/list-prompts`

List all pending prompts in `prompts/to-run/` with their filenames and a brief preview of content.

### `/list-outputs`

List all saved outputs organized by date.

## Inline Prompts (Command Line Questions)

If Daniel asks a question or gives a prompt directly on the command line (rather than via a file in `prompts/to-run/`), treat it as a prompt and run the full workflow automatically:

1. **Record the prompt** — save it as a `.md` file in `prompts/run/` named `YYYYMMDD-HHMMSS-<slug>.md` with the prompt text and timestamp
2. **Research and execute** — carry out the prompt (research, generate content, etc.)
3. **Save output** — write the result to `outputs/YYYY-MM-DD/HHMMSS-<slug>.md` using the standard output format, with `**Prompt source**: `inline (command line)`` instead of a filename
4. **Commit and push**

No need to wait for confirmation — if it looks like a prompt/question, just run it.

## Execution Rules

- Always use Israel Standard Time (IST/IDT) for timestamps
- Create date subdirectories in `outputs/` as needed (e.g., `outputs/2026-03-31/`)
- If a prompt is ambiguous, do your best interpretation and note assumptions in the output
- For audio files, include the transcription at the top of the output before the response
- If a prompt asks you to create files, create them AND save a summary output
- Commit and push after running prompts
- **Each prompt is its own thread** — even follow-up prompts get their own prompt file and output file. Outputs can reference prior context but are never appended to existing files.
- **Clean up typos in prompts** — the prompt text saved to `prompts/run/` should have typos and transcription errors corrected. Daniel often types one-handed.

# General AI Notebook

## Purpose

This is a prompt execution workspace. Daniel places prompts (text files or audio files) in the `prompts/` directory, and Claude runs them and saves outputs with timestamps.

## Directory Structure

```
prompts/
  to-run/       # Queue: place prompt files here to be executed
  run/           # Archive: prompts move here after execution
  audio.md       # Notes on audio prompt handling
outputs/
  YYYY-MM-DD/   # Date-organized markdown outputs
  raw/           # Raw markdown records of chat threads (for PDF generation)
  pdf/           # Generated PDFs
tables/          # CSV data tables generated from research
templates/
  notebook.typ  # Typst template for PDF generation
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

### `/generate-table`

Generate a structured data table from research, saved as both CSV and markdown. Useful for model comparisons, tool evaluations, feature matrices, etc.

**Usage:**
```
/generate-table <topic or description>
```

**Examples:**
```
/generate-table STT models with streaming support and AMD GPU compatibility
/generate-table LLM providers pricing comparison
/generate-table video editing tools for Linux
```

**Process:**

1. **Research** the topic — use prior outputs, web search, and existing knowledge
2. **Design columns** appropriate to the topic. Always include at minimum: Name, Manufacturer/Provider, Description. Add domain-specific columns (e.g., for ML models: Parameters, Architecture, License; for SaaS: Pricing, API Type)
3. **Write CSV** to `tables/<slug>.csv` — this is the canonical data file
4. **Write markdown output** to `outputs/YYYY-MM-DD/HHMMSS-<slug>.md` with the table rendered in markdown and the CSV cross-linked via `**Data file**: [[<slug>.csv|tables/<slug>.csv]]`
5. **Save prompt** and **commit + push** as usual

**Conventions:**
- CSV uses standard RFC 4180 format (quote fields containing commas)
- Boolean columns use `Yes` / `No` / `Partial` (not checkmarks — keeps CSV clean)
- Unknown values use `Unknown` or `N/A`, never blank
- If a table updates a previous one on the same topic, overwrite the CSV and note the update in the output

### `/generate-pdf`

Generate a PDF from one or more outputs using Typst. Accepts several argument forms:

**Single output:**
```
/generate-pdf outputs/2026-03-31/150424-stt-benchmark-realtime-vs-async.md
```

**Multiple outputs (concatenated into one PDF):**
```
/generate-pdf outputs/2026-03-31/150424-stt-benchmark-realtime-vs-async.md outputs/2026-03-31/150908-stt-models-realtime-vs-batch.md
```

**By date (all outputs from a date):**
```
/generate-pdf 2026-03-31
```

**By glob pattern:**
```
/generate-pdf outputs/**/stt-*.md
```

**Process:**

1. **Collect** the specified markdown file(s). If multiple, concatenate in the order given (or chronologically for date/glob), separated by page breaks.
2. **Convert** markdown to Typst markup:
   - Headings: `#` → `= `, `##` → `== `, etc.
   - Bold/italic/code: translate to Typst equivalents
   - Tables: convert to Typst `table()` calls
   - Code blocks: wrap in `` `​`​`lang `` raw blocks
   - Wiki-links `[[...]]`: render as plain text (strip brackets)
   - Metadata block (prompt source, executed, related prompt): render as a styled info box
3. **Write** the `.typ` source to `outputs/raw/<slug>.typ` (preserves the raw Typst source for manual editing)
4. **Compile** with `typst compile` using the `templates/notebook.typ` template
5. **Save** PDF to `outputs/pdf/<slug>.pdf`
6. **Report** the path to the generated PDF

**Naming:** The PDF slug is derived from the input:
- Single file: same slug as the markdown file
- Multiple files / date: `YYYY-MM-DD-combined` or a descriptive slug if a theme is obvious
- User can override: `/generate-pdf --name "my-title" <files...>`

**Template:** Uses `templates/notebook.typ` for consistent formatting (A4, serif, numbered pages, title page).

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
- **Follow-up handling (common sense approach)**:
  - If a follow-up prompt is a natural continuation (new question building on prior context), record it as its own prompt + output pair. Outputs can reference prior context via wiki-links.
  - If a follow-up is a correction to a previous response (e.g., pointing out an error), just edit the prior output in place and delete the correction prompt — no need for a separate file.
  - Use judgement: the goal is a clean, useful vault, not rigid process.
- **Clean up typos in prompts** — the prompt text saved to `prompts/run/` should have typos and transcription errors corrected. Daniel often types one-handed.

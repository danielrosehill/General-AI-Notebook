// General AI Notebook — PDF template
// Used by /generate-pdf slash command

#let notebook-doc(
  title: "AI Notebook Output",
  date: datetime.today().display("[year]-[month]-[day]"),
  author: "Daniel Rosehill",
  body,
) = {
  set document(title: title, author: author)
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2cm, right: 2cm),
    header: context {
      if counter(page).get().first() > 1 {
        set text(8pt, fill: luma(150))
        title
        h(1fr)
        date
      }
    },
    footer: {
      set text(8pt, fill: luma(150))
      h(1fr)
      counter(page).display("1 / 1", both: true)
      h(1fr)
    },
  )

  set text(font: "New Computer Modern", size: 11pt)
  set par(justify: true, leading: 0.65em)
  set heading(numbering: none)

  show heading.where(level: 1): it => {
    set text(size: 18pt, weight: "bold")
    v(0.5em)
    it
    v(0.3em)
  }

  show heading.where(level: 2): it => {
    set text(size: 14pt, weight: "bold")
    v(0.4em)
    it
    v(0.2em)
  }

  show heading.where(level: 3): it => {
    set text(size: 12pt, weight: "bold")
    v(0.3em)
    it
    v(0.15em)
  }

  // Code blocks
  show raw.where(block: true): it => {
    set text(size: 9pt)
    block(
      fill: luma(245),
      inset: 10pt,
      radius: 3pt,
      width: 100%,
      it,
    )
  }

  // Inline code
  show raw.where(block: false): it => {
    box(
      fill: luma(240),
      inset: (x: 3pt, y: 1pt),
      radius: 2pt,
      it,
    )
  }

  // Tables
  set table(
    stroke: 0.5pt + luma(180),
    inset: 6pt,
  )
  show table.cell.where(y: 0): set text(weight: "bold")

  // Title page
  align(center)[
    #v(3cm)
    #text(size: 24pt, weight: "bold")[#title]
    #v(0.5cm)
    #text(size: 12pt, fill: luma(100))[#date]
    #v(0.3cm)
    #line(length: 40%, stroke: 0.5pt + luma(180))
    #v(1cm)
  ]

  body
}

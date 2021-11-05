<!DOCTYPE html>
<html>
    <head>
        <title>Python & Jupyter Notebooks on Savio</title>
        <meta charset="utf-8">
        <style>
         @import url(https://fonts.googleapis.com/css?family=Yanone+Kaffeesatz);
         @import url(https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic);
         @import url(https://fonts.googleapis.com/css?family=Ubuntu+Mono:400,700,400italic);

         body { font-family: 'Droid Serif'; }
         h1, h2, h3 {
             font-family: 'Yanone Kaffeesatz';
             font-weight: normal;
         }
         .remark-code, .remark-inline-code { font-family: 'Ubuntu Mono'; }
         .remark-slide-scaler { overflow-y: auto; }
         .red { color: red; }
        </style>
    </head>
    <body>
        <textarea id="source">
[%- INCLUDE "sections/intro.md" %]
[%- INCLUDE "sections/pip-conda.md" %]
[%- INCLUDE "sections/jupyter.md" %]
        </textarea>
        <script src="https://remarkjs.com/downloads/remark-latest.min.js">
        </script>
        <script>
         var slideshow = remark.create({
             countIncrementalSlides: false,
             highlightLanguage: 'python',
             highlightStyle: 'agate',
             navigation: { scroll: false, },
         });
        </script>
    </body>
</html>

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
         .green { color: green; }
         .blue { color: blue; }
         img { max-width: 100%; }
         .footnote {
         position: absolute;
         bottom: 12px;
         font-size: 14px;
         max-width: 80%;
         }
         .remark-inline-code {
         color: #4c33ff;
         }
         /* Two-column layouts */
         .left-column  { width: 49%; float: left; }
         .right-column { width: 49%; float: right; }
         .right-column ~ p { clear: both; }
         .right-column ~ ul { clear: both; }
        </style>
    </head>
    <body>
        <textarea id="source">
[%- INCLUDE "sections/intro.md" %]
[%- INCLUDE "sections/pip-conda.md" %]
[%- INCLUDE "sections/jupyter.md" %]
[%- INCLUDE "sections/parallel-ipy.md" %]
[%- INCLUDE "sections/parallel-jupyter.md" %]
[%- INCLUDE "sections/parallel-dask.md" %]
[%- INCLUDE "sections/parallel-ray.md" %]
[%- INCLUDE "sections/outro.md" %]
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

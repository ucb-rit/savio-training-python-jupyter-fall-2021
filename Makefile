all: slides.html slides_onepage.html

slides.html: slides.md $(wildcard *.sh *.py) $(shell find sections -type f)
	tpage --define mode="remark" slides.md > $@

slides_onepage.html: slides.md $(wildcard *.sh *.py) $(shell find sections -type f)
	tpage slides.md > slides_onepage.md
	pandoc -s -o slides_onepage.html slides_onepage.md
	rm -rf slides_onepage.md

clean:
	rm -rf slides.html slides_onepage.html

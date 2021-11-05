all: slides.html slides_onepage.html

slides.html: slides.md $(wildcard *.sh *.py) $(shell find sections -type f)
	tpage --define mode="remark" $< > $@

slides_onepage.html: slides.md $(wildcard *.sh *.py) $(shell find sections -type f)
	tpage --define mode="remark" $< > $@
	sed -i -e's/---//g' -e's/--//g' -e's/\(class\|count\|name\|template\):.*//g' $@

clean:
	rm -rf slides.html slides_onepage.html

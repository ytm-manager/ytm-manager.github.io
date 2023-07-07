RC = bundle

_site :
	bundle install

run : _site
	-pkill -f jekyll || True
	@-bundle exec jekyll serve -o --detach > /dev/null 2>&1

.PHONY : clean
clean :
	rm -rf _site

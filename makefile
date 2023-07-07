RC = bundle

_site :
	bundle install

run : _site
	-pkill -f jekyll || True
	@-bundle exec jekyll serve -o --detach > /dev/null 2>&1

# Run foreground verbose
debug : _site
	-pkill -f jekyll || True
	export JEKYLL_LOG_LEVEL=debug
	bundle exec jekyll serve -o --verbose

.PHONY : clean
clean :
	rm -rf _site

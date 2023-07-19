RC = bundle

run : _site
	@-bundle exec jekyll serve -o --detach  # > /dev/null 2>&1

_site : cleanRuntime
	@bundle install

cleanRuntime :
	@echo cleaning
    -pkill -f bundle || :

# Run foreground verbose
debug : _site
	export JEKYLL_LOG_LEVEL=debug
	bundle exec jekyll serve -o --verbose

.PHONY : clean
clean :
	rm -rf _site

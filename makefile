RC = bundle

all :
	bundle install

run :
	-pkill -f jekyll || True
	@-bundle exec jekyll serve -o --detach > /dev/null 2>&1

.PHONY : clean
clean :
	echo Nothing to clean!


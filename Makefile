# Include the common makefile. Must be included at the top. The inclusion is
# optional since on the first run you don't have the common Makefile yet.
-include erl-project/make/Makefile-common.mk
.PHONY : update

#########################################################################
## You can override default settings easily
#########################################################################

#COOKIE=i_want_a_different_cookie
# The app name is resolved by looking for an *.app.src file, but you can
# override this by defining the APP variable yourself.  For example if your
# project is not rebarized (for whatever reasons...) or is not using an
# .app.src file. (This is terrible though!)
#APP=this_is_the_real_app_name

CONFIG=conf/erl_monitoring.config

#########################################################################
## Common targets
#########################################################################

# First/default make target (it is run when you do 'make' without an explicit
# target). The semicolon signifies inheritance from the common Makefile, so
# the "all" target on the common Makefile is executed first and after that the
# this "all" is being executed.
all:: update
#	echo "This is some stuff happening in this project specifically."

# These targets must be defined here explicitly because CI/Deployar executes
# them initially, when there is still no common Makefile available.
setup:: update
#	echo "You can also extend them."

getdeps:: update

#########################################################################
## Do not edit below
#########################################################################

# Update erl-project. Allow failures of git (eg. executing git inside Mock env)
update: erl-project
	@echo "Updating erl-project"
	-@cd erl-project && git pull && cd ..

# Clone erl-project (only once executed) and add it to .gitignore
erl-project:
	@echo "Cloning erl-project"
	-@git clone -q git@github.com:spilgames/erl-project.git
	@test "`grep erl-project .gitignore`" || echo "erl-project/" >> .gitignore
	@make $(MAKECMDGOALS)

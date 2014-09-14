# docker-perl6

Image with a Perl6 installation with all Rakudo Star modules installed.

The following components are included:

 - Rakudo (the Perl6 compiler)
 - MoarVM (with JIT enabled)
 - The Rakudo Star module list
 - The Perl6 modules tools: panda and ufo

There are two versions of this image:

 - latest (git branch: master)
 - unstable (git branch: blead)

The 'latest' build is based on the last Rakudo release (presently
2014.08) and the 'unstable' build is based on the HEAD of alle relevant
git repositories.

## See also

 - The Docker Hub Repository: https://registry.hub.docker.com/u/pmakholm/perl6/
 - The GitHub repository: https://github.com/pmakholm/docker-perl6

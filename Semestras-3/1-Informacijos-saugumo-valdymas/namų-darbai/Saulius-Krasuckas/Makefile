# 2022-02-17 saukrs: darau pagal https://makefiletutorial.com/#targets
#

all: titulinis ND1

titulinis: ND-titulinis.pdf

ND-titulinis.pdf: ND-titulinis.adoc
	git pull
	scp ND.yml ND*.adoc swarm-n01-oam:
	ssh -t swarm-n01-oam sudo 'docker run -it -u "$$(id -u)" -v $${PWD}:/documents/ asciidoctor/docker-asciidoctor asciidoctor-pdf ND-titulinis.adoc'
	scp swarm-n01-oam:ND-titulinis.pdf .
	explorer ND-titulinis.pdf
ND1:

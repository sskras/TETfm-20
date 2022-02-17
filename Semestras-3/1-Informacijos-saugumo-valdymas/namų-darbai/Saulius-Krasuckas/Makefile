# 2022-02-17 saukrs: darau pagal https://makefiletutorial.com/#targets
#

all: tit ND1

tit: ND-titulinis.pdf titulini-rodom

ND-titulinis.pdf: ND-titulinis.adoc
	ssh -t swarm-n01-oam sudo 'docker run -it -u "$$(id -u)" -v $${PWD}:/documents/ asciidoctor/docker-asciidoctor asciidoctor-pdf ND-titulinis.adoc'
	scp swarm-n01-oam:ND-titulinis.pdf .

ND-titulinis.adoc:
	scp ND.yml ND*.adoc swarm-n01-oam:

titulini-rodom:
	explorer ND-titulinis.pdf || true

ND1:

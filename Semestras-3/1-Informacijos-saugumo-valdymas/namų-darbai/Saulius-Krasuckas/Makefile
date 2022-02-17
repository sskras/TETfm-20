# 2022-02-17 saukrs: darau pagal https://makefiletutorial.com/#targets
#

all: ND1

ND: ND.pdf rodom-ND

tit: ND-titulinis.pdf rodom-titulini

ND-titulinis.pdf: ND-titulinis.adoc
	ssh -t swarm-n01-oam sudo 'docker run -it -u "$$(id -u)" -v $${PWD}:/documents/ asciidoctor/docker-asciidoctor asciidoctor-pdf ND-titulinis.adoc'
	scp swarm-n01-oam:ND-titulinis.pdf .

ND-titulinis.adoc:
	scp ND.yml ND*.adoc swarm-n01-oam:

rodom-titulini:
	explorer ND-titulinis.pdf || true

ND1: ND1-ataskaita.pdf rodom-ND1

ND1-ataskaita.pdf: ND1-ataskaita.adoc
	ssh -t swarm-n01-oam sudo 'docker run -it -u "$$(id -u)" -v $${PWD}:/documents/ asciidoctor/docker-asciidoctor asciidoctor-pdf -a allow-uri-read ND1-ataskaita.adoc'
	scp swarm-n01-oam:ND1-ataskaita.pdf .

rodom-ND1:
	explorer ND1-ataskaita.pdf || true

ND.pdf: ND-titulinis.pdf ND1-ataskaita.pdf
	/mingw64/bin/qpdf --empty --pages ND-titulinis.pdf ND1-ataskaita.pdf 2-z -- ND.pdf

rodom-ND:
	explorer ND.pdf || true

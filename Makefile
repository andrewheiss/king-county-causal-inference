remote_host = cloud
remote_dir = ~/sites/stats/public_html/king-county
remote_dest = $(remote_host):$(remote_dir)

.PHONY: build upload serve

serve:
	quarto preview

build:
	quarto render

upload:
	rsync -crvP --delete _site/ $(remote_dest)

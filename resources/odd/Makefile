HOST ?= http://localhost:8080
APP ?= scdh-edition
ODDROOT ?= resources/odd

EXISTHOME ?= /opt/exist-db/exist-distribution-5.2.0

# authentication with tei/simple
AUTH ?= Basic dGVpOnNpbXBsZQ==

# list of ODDs
ODDS ?= SCDH.odd

.PHONY: compile deploy getall putall

compile:
	curl -X 'POST' \
	'$(HOST)/exist/apps/$(APP)/api/odd?check=false' \
	-H 'accept: text/html' \
	-H 'Authorization: $(AUTH)' \
	-d ''

deploy:	putall compile

## Using `curl PUT /api/odd/some.odd` garbles the odd. For that reason
## we use the client:
putall:	$(ODDS) put.txt
	$(EXISTHOME)/bin/client.sh --no-gui < put.txt

put.txt: $(ODDS)
	echo "cd apps/$(APP)/$(ODDROOT)" > $@
	for odd in $^ ; do echo "put $<" >> $@ ; done

getall:	$(ODDS)

%.odd:
	curl -X 'GET' \
	"$(HOST)/exist/apps/$(APP)/api/odd/$@" \
	-H 'accept: application/xml' \
	-H 'Authorization: $(AUTH)' \
	-o $@

all: deps fmt combined

combined:
	go install .

release: release-deps
	gox -output="build/{{.Dir}}_{{.OS}}_{{.Arch}}" .

fmt:
	go fmt ./...

deps:
	go get github.com/HokieTT/MailHog-Server
	go get github.com/mailhog/MailHog-UI
	cd ../MailHog-UI; make bindata
	go get github.com/mailhog/http
	go get github.com/ian-kent/gotcha/gotcha
	go get github.com/ian-kent/go-log/log
	go get github.com/ian-kent/envconf
	go get github.com/ian-kent/goose
	go get github.com/ian-kent/linkio
	go get github.com/jteeuwen/go-bindata/...
	go get labix.org/v2/mgo
	# added to fix travis issues
	go get github.com/pborman/uuid
	go get code.google.com/p/go.crypto/bcrypt

test-deps:
	go get github.com/smartystreets/goconvey

release-deps:
	go get github.com/mitchellh/gox

.PNONY: all combined release fmt deps test-deps release-deps

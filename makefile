.PHONY: build install clean envinfo

# binary name
BINARY_NAME := todo

# detect os
OS := $(shell uname -s 2>/dev/null || echo Windows)

# set go env
ifeq ($(OS),Windows)
    # windows path
    export USERNAME := $(shell cmd.exe /c "echo %USERNAME%" 2>NUL)
    export GOPATH := C:/Users/$(USERNAME)/go
    export GOCACHE := C:/Users/$(USERNAME)/AppData/Local/go-build
    export GOMODCACHE := $(GOPATH)/pkg/mod
    export TMP := C:/Users/$(USERNAME)/AppData/Local/Temp
    export TEMP := $(TMP)
else
    # linux or mac path
    export GOPATH := $(HOME)/go
    export GOCACHE := $(HOME)/.cache/go-build
    export GOMODCACHE := $(GOPATH)/pkg/mod
    export TMP := /tmp
    export TEMP := /tmp
endif

#-------------------------------
# commands
#-------------------------------

build:
	@echo "🔧 Building for $(OS)..."
	go build -buildvcs=false -o $(BINARY_NAME) .
	@echo "✅ Build complete: ./$(BINARY_NAME)"

install: build
	@echo "📦 Installing..."
ifeq ($(OS),Windows)
	mkdir -p $(GOPATH)/bin
	cp $(BINARY_NAME).exe $(GOPATH)/bin/$(BINARY_NAME).exe
	@echo "✅ Installed to $(GOPATH)/bin"
else
	install -m 0755 $(BINARY_NAME) /usr/local/bin/$(BINARY_NAME)
	@echo "✅ Installed to /usr/local/bin"
endif

clean:
	@echo "🧹 Cleaning..."
	rm -f $(BINARY_NAME) $(BINARY_NAME).exe

envinfo:
	@echo "📋 Environment Info:"
	go env | grep -E "GOPATH|GOCACHE|GOMODCACHE|TEMP|TMP"

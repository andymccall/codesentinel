# ----------------------------
# Makefile Options
# ----------------------------

NAME       = cs
CA65       = ca65
AR65       = ar65
CL65       = cl65
RM         = rm -f
NEOEMU     = neo
NEO_HOME   = ~/development/tools/neo6502/

# List all the source files that need to be compiled and linked together.
SOURCES =   src/main.asm \
            src/app/app.asm \
            src/app/messages.asm \
            src/app/handlers/main.asm \
            src/app/handlers/file.asm \
            src/app/handlers/edit.asm \
            src/app/handlers/help.asm \
            src/app/actions/new.asm \
            src/app/actions/open.asm \
            src/app/actions/save.asm \
            src/app/actions/cut.asm \
            src/app/actions/copy.asm \
            src/app/actions/paste.asm \
            src/app/actions/about.asm \
            src/lib/menu.asm \
            src/drivers/neo6502/video.asm \
            src/drivers/neo6502/input.asm

default: all

all:
	@echo "Building project..."
	mkdir -p bin
	mkdir -p lst
	mkdir -p map
	$(CL65) --static-locals -t none -C src/includes/system/neo6502.cfg -O --cpu 65c02 -l lst/$(NAME).lst -m map/$(NAME).map -o bin/$(NAME).bin $(SOURCES) src/includes/system/neo6502.lib
	python3 $(NEO_HOME)exec.zip bin/$(NAME).bin@800 run@800 -o"bin/$(NAME).neo"
	rm bin/$(NAME).bin

clean:
	@echo "Cleaning project..."
	rm -rf bin
	rm -rf lst
	rm -rf map
	rm -rf *.bin
	rm -rf storage
	if [ -f memory.dump ]; then rm memory.dump; fi

run:
	@echo "Launching emulator..."
	mkdir -p storage
	cp bin/$(NAME).neo storage
	$(NEOEMU) bin/$(NAME).neo cold
	rm -rf storage
	rm memory.dump


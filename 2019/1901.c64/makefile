PETCAT=petcat
C1541=c1541

OBJ_DIR=obj
IMG=$(OBJ_DIR)/image.d64
MKDIR_P=mkdir -p

BASICS=$(wildcard *.bas)
INPUTS=$(wildcard *.in)

PRGS=$(patsubst %.bas, $(OBJ_DIR)/%.prg, $(BASICS))
SEQS=$(patsubst %.in, $(OBJ_DIR)/%.seq, $(INPUTS))

$(shell $(MKDIR_P) $(OBJ_DIR))

.PHONY: all delete-image build-image write-prg write-seq clean

$(OBJ_DIR)/%.prg: %.bas
	$(PETCAT) -v -w2 -o $@ -- $<

$(OBJ_DIR)/%.seq: %.in
	$(PETCAT) -text -v -w2 -o $@ -- $<
	
$(OBJ_DIR)/%.d64: $(PRGS) $(SEQS)
	$(C1541) -format $(notdir $(patsubst %.d64,%,$@)),dd d64 $@ 

all: delete-image build-image write-prg write-seq

delete-image:
	rm -f $(IMG)

build-image: $(IMG)

write-prg: $(PRGS)
	$(C1541) -attach $(IMG) -write $< $(notdir $(patsubst %.prg,%,$<))

write-seq: $(SEQS)
	$(C1541) -attach $(IMG) -write $< "$(notdir $<),s"

clean:
	rm -rf $(OBJ_DIR)

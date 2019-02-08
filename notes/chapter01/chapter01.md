# Basic Concepts

## Welcome to Assembly Language

### Terms and Definitions

- *assembler*: utility program that converts source code into machine language.
  Assembly language is ***not*** portable because it's designed to run on a
  *family* of processors

- *linker*: utility program that combines individual files created by an
  assembler into a single executable

- *machine language*: numeric language understood by the CPU

- *assembly language*: statements written with short mnemonics (e.g., `ADD`,
  `MOV`, `SUB`, etc.). Has a one-to-one relationship with machine language

- *portable*: run on a wide variety of computer systems

- *one-to-one*: each instruction in one language corresponds to another
  instruction in another language

## Virtual Machine Concept

Programs can be written in a computer's native *machine language*, but this is
difficult for programmers because it is entirely numerical (e.g., binary or
hexadecimal) and very detailed. Let's call the machine language **L1**.
Therefore, a new language, L1, can be made such that it's easier for
programmers to write programs in. This can be accomplished by *interpreting*
L1 into L0 or by *translating* L1 into L0.

### Virtual Machines

It can be helpful to think in terms of a hypothetical computer (virtual machine)
instead of thinking in terms of languages. In this line of thinking, a virtual
machine **V1** executes programs written in L1 and a virtual machine **V0**
executes programs written in L0.

Virtual machines can be constructed of hardware or software and programs can be
written for VM1 which can be executed on hardware if it's practical to make V1\
as a physical computer. Or, programs can be written for VM1 can be
translated/interpreted from VM1 and executed on VM0.

VM1 and VM0 cannot be too different otherwise the translation/interpretation
process would be time consuming. If L1 is not practical enough for programmers,
then more virtual machines can be made and chained together until a
practical, yet powerful, enough language is constructed. This is, for example,
how Java works.

Java is based on the virtual machine concept and is translated from Java into
Java byte code by the Java compiler. Java bye code is a low-level language
that's quickly executed at runtime by the Java virtual machine which has been
implemented on many different computer systems which makes Java portable.

### Specific Machines

Instead of using VM1 and VM2, let's use levels such that **Level 2** corresponds
to VM2, **Level 1** corresponds to VM1, and so on. Level 1 will be the
computer's digital logic hardware.

- *Instruction Set Architecture (Level 2)*: instruction set to carry out basic
  operations (move, add, multiply) which is also known as machine language. Each
  instruction is executed directly by the computer's hardware or by a program
  embedded in microprocessor called a *microprogram*.

- *Assembly Language (Level 3)*: Assembly language uses short mnemonics such as
  `ADD`, `MOV`, or `SUB` which are translated to the ISA level. Assembly
  language programs are entirely translated to machine language before they
  are executed.

- *High-Level Languages (Level 4)*: Programs at level 4 are translated into\
  assembly language instructions. Examples of languages at this level are Java,
  C++, and C.

Figure \ref{virtual_machine_levels} shows how the levels of virtual machines
are chained together.

![Virtual machine levels\label{virtual_machine_levels}](virtual_machine_levels.png "Virtual machine levels")

### Terms and Definitions

- *virtual machine*: software program that emulates the functions of some other
  physical or virtual computer

- *interpretation*: decoding of a program's L1 instructions by a program written
in L0. The L1 program is run immediately, but is decoded before it is executed

- *translation*: a program written in L1 is converted into an L0 program by a
program written in L0 that's be designed for this purpose. The result can then
be run directly on the computer's hardware

## Data Representation

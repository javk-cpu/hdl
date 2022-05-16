# hdl

> JAVK Verilog


## Building

You'll need [GNU Make] and [Icarus Verilog].

```sh
make
```

This should create the `build/` directory and build all available test
benches.


## Running the JAVK Test Bench

The test bench expects a file called `a.hex` in the current working directory.
This file is loaded starting at address zero and must be a plain text file with
a hex byte on each new line.  While the test bench is running, it dumps all
instantiated modules to a file named `a.vcd`.  Terminal output also reflects
the current state of the CPU.


## Copyright & Licensing

Copyright (C) 2022  Jacob Koziej [`<jacobkoziej@gmail.com>`]

Copyright (C) 2022  Ani Vardanyan [`<ani.var.2003@gmail.com>`]

Distributed under the [GPLv3] or later.


[GNU Make]: https://www.gnu.org/software/make/
[Icarus Verilog]: http://iverilog.icarus.com/
[`<jacobkoziej@gmail.com>`]: mailto:jacobkoziej@gmail.com
[`<ani.var.2003@gmail.com>`]: mailto:ani.var.2003@gmail.com
[GPLv3]: LICENSE.md

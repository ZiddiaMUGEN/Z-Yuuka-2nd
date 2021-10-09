This folder contains all the supernull documentation + code.

The basics for the exploit are covered in https://ziddia.blog.fc2.com/blog-entry-63.html - however, a simple understanding is that there is a buffer overflow in the AssertSpecial Flag parameter which can be leveraged for arbitrary code execution at parse time (i.e., supernull).

Because MUGEN 1.0+ has DEP enabled in the binary, a specific technique is used to reach arbitrary code execution. The technique used is return-oriented programming (ROP). By carefully crafting a sequence of bytes in the AssertSpecial buffer overflow, we can take control of the flow of execution of the program and force it to disable DEP in some regions, enabling true ACE.

This version of the supernull exploit is compatible with all MUGEN versions past 1.0. This was achieved by designing a ROP chain which functioned on all 3 version (using shared DLLs), as well as adjusting the bootstrap and loader code to adjust behaviour based on the version.

This version of the exploit is split into 4 stages. The first 3 stages can be left the same for ALL characters using the exploit, while only the fourth stage needs to be changed.

Details:

1. ROP
- positioned immediately after the buffer overflow (after 64 characters, `A` in my example)
- take control of EIP (flow of execution of the program, basically allows executing any code that already exists inside MUGEN and its DLLs)
- use this control of EIP to force the program to remove memory protections on the stack (allows code execution on the stack)

2. Bootstrap
- positioned immediately after the ROP (still on the same line as the buffer overflow!)
- is a limited form of ACE (with restricted usable bytes and a small amount of available space)
- purpose is to find the location of the supernull file in memory, remove memory protections on its location, and move execution to the top of the file

3. Loader
- positioned at the top of the supernull file
- this will be ignored by MUGEN during parsing, but will still exist in memory, allowing us to store code here.
- this is much more free on bytes and space compared to the bootstrap, while still having minor restrictions.
- goal is to load a binary file into memory based on the MUGEN version, allowing ACE which targets a specific version without using complex branches.

4. Binary
- exists in several separate files in the character folder - one for each of the 3 MUGEN versions supported
- intention is to provide a consistent way for developers to write their own code using the exploit
- in this file, there are no restrictions on bytes or size, so developers can write their ACE freely.

As you can see, if you want to make use of this exploit, you never need to change the first 3 steps - only the binaries need to be updated with your own intended code.
As all 3 of the first stages exist in `Supernull.st`, the same supernull file can just be re-used.
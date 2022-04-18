# Nvim configuration
**Author:** Lucas Hernández Abreu
**Email:** alu0101317496
----

# Use

## DEFX
*Search for files or create*
<br>
To initiate the file explorer press:
```vim
<Space> + nt
```
### Options
**Open file**
"\<CR\>", "l" or "o"

**New file**
Press "N" and write the name

**Navigate:**
- "k": up
- "j": down
- "l": open the file
- "h": go back -> `cd ..`


----

## Copilot

Run:
```vim
" Start with
:Copilot setup
" To use the suggestion use tab
```

----

## Fixes the JSDOC in treesitter parser

Go to the folder with the data of nvim and enter `nvim-treesitter/queries/ecma/indents.scm`

At the end of the file change the following line to:
```scm
  [
    (comment) @auto 
    (template_string)
  ] @ignore
```

Now the problem will be temporally fixed

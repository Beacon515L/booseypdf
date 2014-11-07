booseypdf
=========
by Beacon515L, 2014

Downloads scores from the Boosey and Hawkes web scores portal to PDF.

Disclaimer
----------

This tool is purely proof of concept.  I in no way condone or encourage piracy or illegal procurement of musical scores.

Changelog
----------
2014-11-08T0014 - v1.0a - initial commit.

Dependencies
------------
wget, sed, tr, swfextract, imagemagick, pdfunite, find, awk

Usage
------

Syntax: booseypdf.sh base_path output_file.pdf

1. Register for an account at http://www.boosey.com/cr/perusals/, or if you have one, log in.  You will not otherwise be able to get the base_url.
2. Navigate to the entry page for the desired score.  For example, Bernstein's Symphonic Suite from On The Waterfront is located at http://www.boosey.com/cr/perusals/score.asp?id=1405.
3. Switch to source code view in your browser; this is most often CTRL-U.
4. Search for the word 'base' around line 223 (CTRL-F can help).  It is a variable name in a set of flash params.  In the case of the Bernstein work aforementioned, this value is /perusals/mormaqlhi2o_1405/.  This is the value of base_url; copy it to the clipboard.
5. In a terminal, navigate to your desired output directory.
6. Run the command.  The invockation to download the Bernstein would look like the following:
  booseypdf.sh /perusals/mormaqlhi2o_1405/ foo.pdf
7. Depending on the number of pages the script may take some time to complete, particularly at the PNG->PDF stage.

Working Principle
------------------
Boosey and Hawkes store scores for their perusals portal in individual SWFs for pages.  These SWFs contain PNGs, which are the actual scans.  The script downloads the XML the portal uses for the page list, parses a list of URLs for the hires SWFs and passes it to wget.  Once they are all down, swfextract converts the SWFs to PNGs, then imagemagick converts the PNGs to PDFs.  Finally, pdfunite combines all the pages to a single PDF file.

That the B&H perusals portal does not incorporate any measure of internal or external security beyond a small degree of obfuscation is illustrative of the insecurity of such a system, and the publishing of this script is intended to draw attention to that fact.

Known Issues
-------------
Could stand to be implemented more efficiently, particularly the conversion stages.

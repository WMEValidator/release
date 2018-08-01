ABOUT
=====
This is the release files of WME Validator.

WME Validator uses Open Source GPLv3 license, i.e. you may copy,
distribute and modify the software as long as you track changes/dates
in source files. Any modifications to or software including
(via compiler) GPL-licensed code must also be made available under
the GPL along with build & install instructions.

Please check the doc directory for more information.

For questions please use official forum:<br/>
https://www.waze.com/forum/viewtopic.php?f=819&t=76488

Report bugs on GitHub Issues Tracker:<br/>
https://github.com/WMEValidator/validator/issues


QUICK START
===========
In validator repo:

1. Fetch the latest changes:

    $ git fetch origin --recurse-submodules

2. Review all the changes.

3. Update doc/ChangeLog.txt

4. Update src/release.js:
   - WV_VERSION
   - WV_WHATSNEW

5. Update meta/meta-begin.js
   - @version
   - @contributor

6. Update references to submodules:

   $ git submodule update --remote

7. Compile Validator and test the changes:

   $ ./10.release.sh

8. Create a commit called "New version"


In release repo:

1. Put a compiled WME Validator file into the 'build' directory.

2. Put a Chrome Web Store key into the 'priv' directory.

3. Run 10.release.sh

4. The result files will appear in the 'release' directory.

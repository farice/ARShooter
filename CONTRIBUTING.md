## Contribution tips and guidelines

### Pull requests are welcome

Don't hesitate to fix small bugs. Significant changes should be documented as [a GitHub issue](https://github.com/farice/arshooter/issues) before work is performed.

### Conventions

Fork the repository and make changes on your fork in a feature branch:

- If it's a bug fix branch, name it XXXX-bug_description where XXXX is the GitHub issue number. 
- If it's a feature branch, create an enhancement issue, and name it XXXX-enhancement_description where XXXX is the GitHub issue number.

Update the documentation when creating or modifying features.

Write clean code.

Pull request descriptions should be as clear as possible and reference relevant issues.

### Sign your work

The sign-off is a simple line at the end of the explanation for the patch. Your
signature certifies that you wrote the patch or otherwise have the right to pass
it on as an open-source patch. If you can certify
the below (from [developercertificate.org](http://developercertificate.org/)):

```
Developer Certificate of Origin
Version 1.1

Copyright (C) 2004, 2006 The Linux Foundation and its contributors.
1 Letterman Drive
Suite D4700
San Francisco, CA, 94129

Everyone is permitted to copy and distribute verbatim copies of this
license document, but changing it is not allowed.

Developer's Certificate of Origin 1.1

By making a contribution to this project, I certify that:

(a) The contribution was created in whole or in part by me and I
    have the right to submit it under the open source license
    indicated in the file; or

(b) The contribution is based upon previous work that, to the best
    of my knowledge, is covered under an appropriate open source
    license and I have the right under that license to submit that
    work with modifications, whether created in whole or in part
    by me, under the same open source license (unless I am
    permitted to submit under a different license), as indicated
    in the file; or

(c) The contribution was provided directly to me by some other
    person who certified (a), (b) or (c) and I have not modified
    it.

(d) I understand and agree that this project and the contribution
    are public and that a record of the contribution (including all
    personal information I submit with it, including my sign-off) is
    maintained indefinitely and may be redistributed consistent with
    this project or the open source license(s) involved.
```

Then you just add a line to every git commit message:

    Signed-off-by: John Appleseed <john.appleseed@email.com>

Use your real name.

If you set your `user.name` and `user.email` git configs, you can sign your
commit automatically with `git commit -s`.

---

> Based substantially on [Docker contributing guidelines](https://raw.githubusercontent.com/moby/moby/master/CONTRIBUTING.md)

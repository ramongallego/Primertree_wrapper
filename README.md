# NewProject

## How to use it

Fork this (or jimmy's from https://github.com/jimmyodonnell/NewProject) to your github, and then

go to `Settings` and check `Template repository`.

THen, when you start a new repository, select this repository in the drop down menu


So, you want to "do the science", eh? This is a template for starting a new project in an organized fashion. I set this up in order to streamline project management. I'd love to hear any feedback you might have. - [Jimmy O'Donnell](mailto:jodonnellbio@gmail.com)

The general directory structure is:

- **readme.md**

  A general purpose text file for describing the project. Also useful for keeping a log of TODOs, goals, task assignments, etc.

- **Analysis/**

  All of your code or documentation to manipulate raw data.

- **Data/**

  Data, preferably in as raw a format as possible. Pro-tip: follow  [Karl Broman's guidelines!](http://kbroman.org/dataorg/) You should strive to keep the data as close to their raw state as possible. To fix typos and other errors, do so upon loading the data so that it's documented! For extra-large data files, you might want to house them outside this directory (e.g. on Google Drive) and keep a text file with links. If this is tracked by git, you should not compress it (git manages compression internally).

- **Figures/**

  This should contain files that are some sort of image format (.pdf, .png, .tif, etc), as well as an accompanying legend for each image, in plain text format.

- **Vault/** (*optional*)

  If any of your coauthors are skeptical of version control, and wants to save every version of every figure by hand, create this directory for them and let them dump that stuff here (you would never do that though, right?).

- **Documents/**

  All documentation (except the project readme), with at least one subdirectory for the manuscript.

  - **Proposal/** (*optional*)

    If there is a funding proposal, keep it here. You could start every project in this format right from the start of proposal writing, but at the very least, the proposal should be stored here so that collaborators are all on the same page regarding what products were promised.

  - **References/** (*optional*)

    I almost never use this now, but some people love keeping PDFs in the project directory. This could be nice for sharing newly discovered papers among collaborators, but I think it's a recipe for excessive duplication on your computer.

  - **Manuscript/**

    This should probably *never* contain a manuscript file right in this directory -- if you are doing science, you are certain to end up with many versions from many authors. Some people let their version control system (e.g. git, svn) handle all of the versions, but this isn't friendly to non-VCS types and can be a pain upon dealing with manuscript submission and formatting. I prefer to keep each version in it's own subdirectory. In line with [semantic versioning](http://semver.org/) for software, I try to use the first digit for "major releases" (i.e. journal submissions) and the second digit for "minor releases" (i.e. internal revisions). v0.1 is the very first draft, and after each time you circulate the manuscript and get feedback from coauthors, you should start a new internal version (I have sometimes used v0.0 to indicate a *very* rough draft. I'm actually not sure whether v0.0 or v0.1 should be preferred). If you want to store internal (i.e. to you, the project manager) iterations, those should be noted in a third digit place, e.g. v0.2.2.

    Here is an example workflow:

    - *v0.1*: The very first draft. Send a link to the directory to coauthors. They comment and make changes. You copy the directory and name the copy...

    - *v0.2*: Now you incorporate everybody's changes, and send a link to the manuscript back out. Everyone agrees, *this* version is now flawless. You copy the directory and rename it...

    - *v1.0*: This is the version you send to Science. You now also have a file in here for the cover letter. Science rejects it outright. You copy this directory and rename it...

    - *v2.0*: This is the version you submit to Nature. It goes out for review, but gets rejected with encouragement to resubmit. So, you copy this directory and rename it...

    - *v2.1*: Now you also add a file containing the reviews and a file containing your responses. You make changes to the manuscript, send it to coauthors, some of whom acknowledge your email, and one of whom makes a few changes. So you copy the directory, and rename it...

    - *v2.2*: This is the version you send back to Nature, with your revised cover letter and response to reviews. Nature rejects it, so you copy and rename it...

    - *v3.0*: This is the version you send to PNAS...

    - ...

    - *v28.4*: This is the final iteration of responding to reviewers at the Southwestern Oklahoma Journal of Oceanography.

    - *vPUBLISHED*: Your article has been ACCEPTED! This is where you put the final author's proofs and copyediting bullshittery. You can now archive this whole directory, write it to a floppy disk, and throw it in the garbage (or e-cycling, where facilities exist). Congratulations! Science!

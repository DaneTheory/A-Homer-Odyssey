A Homer Odyssey

# Homer's Awesome Coding Challenge
> Solution By: Branden Dane

---

## The Challenge
> The goal of this code challenge is to give an idea on how you think, organize code, and solve
problems. We expect for this code exercise to take 5 to 7 hours total for a senior engineer.

---

## Requirements
  - Use Node.js, and handle exceptions if a file cannot be read in or written to.

  - Your deliverable should be easily installed on a Nix' machine by an engineer familiar with brew, npm etc.

---

### Part 1
> Write a command line script that will load `stories.csv` into a simple table in a MySQL database.

  - Use the table structure defined in `content.sql`.

  - The records should be entered in batches, 20 per batch.

---

### Part 2
> Write RESTful web service(s) that would make it possible to create, update, delete, read a single story as well as list all stories.

_**Note:** Feel free to use a third party library for the web services_

---

### Part 3
> Write a command line script that will call the list stories API endpoint, then analyzes the data and generates a valid_stories.csv file.

_**Rules for a valid story:**_
1. The story must be public
2. The story must have over 20 likes
3. The story launch date is after 2012‑01‑01

---

## Initial Thoughts Before Doing Anything

**On Requirements**
> 1. Use Node.js, and handle exceptions if a file cannot be read in or written to.

Out of the box, NodeJS gives us the ability to natively manipulate the Filesystem in numerous ways. The most obvious being the `fs` module built-in to NodeJS itself. However, while `fs` can handle this requirement it's rather cumbersome in doing so. Unless dealing with streams, read/writes will be synchronous actions. Having these actions resolve/reject via promises, or even better via async/await, ensures synchronous actions are complete before any other operation should be allowed to take place. Exceptions on if a file is able to be read/written to can depend on numerous restrictions, the most obvious being permissions already set on the file in question. Other exceptions of note should be whether the data intended to be written to a file already exists. Moreso, in order to ensure consistency in a final output where the data is used, rules validating the data to be written must be in place in so that all data entries conform to a uniform standard that can be read whenever needed. Lastly, it's always a good idea to make sure the file being read/written is the file `type` that we want out program to work with (Not just CSV, but ignore TXT or even Directories as well).

_So..._
  - First off, the program should accept a file derived from an absolute path provided from the User. But it's 2019 and that's no fun. We can still provide that as a fallback, but since other parts of this challenge discuss spinning up web-services to deal with this data, why not have a nice little GUI with a button that opens up a propmpt for the User to select the file they would like to import. Even better, provide the User an input for the absolute path where the program can automatically check for files to use within "auto-magically".
  - Incoporate a 3rd party lib for dealing with Filesystem in NodeJS.
    Options:
      - fs-jetpack https://github.com/szwacz/fs-jetpack
        Pros:
        - Sync/Async Filesystem manipulation for all `fs` related capabilities and more.
        - File type verification
        - Read/Write permissions for files
  - Errors/Exceptions that occur on read/write should be logged, obviously. I won't craft anything crazy to tackle this problem. There are too numerous elegant ways to properly log these things. However, other than basic log generation, since we are providing a front-end of sorts it makes sense to let the User know an error occurred of some-kind as well. In a format that's easy for Humans to understand. That's more fun.


> 2. Your deliverable should be easily installed on a Nix' machine by an engineer familiar with brew, npm etc.  

I love that this was added on as a requirement. Often times Engineers/Developers reach for Docker/Vagrant/etc. to ensure consistent build environments via containerization. There's nothing at all wrong with this practice. Had this challenge been greater in scale, I'm sure I would have gone for a full proof container deployment as well. However, NodeJS apps offer a few native tricks to ensuring they are run properly; falling back on the developer/engineer to provide an environment that is setup correctly to run a program as intended. Particular headaches with relatively simple solutions are in making sure the NodeJS version running the application is consistent and the "Package Manager" handling the build is consistent cross-environment.

_So..._
  - In a perfect world, everything would always run as expected. But since this world is primarily composed of people, mistakes are bound to happen. My personal flow for starting work on an existing project is:
    1. Visit the Source Control setup used for Versioning/CI of the application, then read the Installation/Getting Started instructions offered in a README, and finally download the project onto my local machine and run the commands to get started as instructed. If a problem does arise during the initial setup, the error and underlying explanation, ideally, should be clearly explained and thus easy to remedy for another go at running the program.
  In order to satisfy this piece, we'll make some hard decisions in what the program needs to execute properly. These are:
   * Yarn - Package Manager with needed version requirement
   * NodeJS - Needed version requirement
   * Restrictions against using alternative Package Managers (like NPM). While not completely necessary, NPM and Yarn operate in two very different ways. I persoanlly prefer Yarn. Why? Among many reasons, mainly for the next point,
   * Yarn Workspaces - This way we can build this entire solution as a MonoRepo. Making it easier to maintain and scale (though overkill yes for this) but development becomes much smoother overall nonetheless.

---

_Last bit..._
 - Since we are going to be building RESTful web-services, and I've grown quite found of Serverless Lambdas, I'll be using Zeit Now https://zeit.co/dashboard for dev => prod deployments. Production builds are limited to NodeJS 10.15.3 I believe at the time of writing this. Yarn 1.17.3 is the latest version available and is supported on Zeit's platform. I'll be using Zeit's development pipeline which looks something like this:
  - Running `now dev` in terminal on my local machine will mimic the overall production, Serverless environment.
  - Running `now target --staging` directly will build a live staging from which to test code for any bugs.
  - Running `now target --prod` directly will build a live production version of the final program in production.
  - Zeit supports building for Monorepos right out of the box which is another pro in using this solution, as well as offering webhooks on git (Github) commits that can automatically rebuild staged/test/whatever environments on the fly.
 - I will say, I hAve considerable expereince using Zeit Now, but it's very similar to AWS and how Lambdas work there. The only "cheating" I'll be doing is I have already configured Zeit to dynamically generate DNS for new projects. All of which will run via HTTPS (Certs are autogenerated on the fly. It's awesome!)
 - The MAJOR con to using Zeit is, unlike AWS, it is completely dedicated to Serverless, immutable builds. So no databases to easily integrate with. I'll have to figure out a 3rd party MySQL solution for this project. No worries. I'm sure it's doable. That, or I'll hack something together!


 _Ok, actually the last bit..._
  - My biggest weakness going into this in working against MySQL. It's been quite some time. I don't expect to produce the most optimized queries, nor will I attempt to do so. Normally in an actual work environment, I like to defer to my colleagues who are better specialized on these particular areas where I lack for guidance. I will never claim to be an expert at any one thing, and find no reason to try and pretend to be great at something I'm not. In my experience, this only makes it more difficult for me to learn on a personal level and ultimately can stunt a team if people are not honest with their own strengths and/or weaknesses.

OK! End rant. Moving on to the outline plan of TODO's...

---

## TODOs
> Created a Github Projects Board to track TODO's
https://github.com/DaneTheory/A-Homer-Odyssey/projects/1

This is going to be fun. Here goes!

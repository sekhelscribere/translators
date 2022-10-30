## Haskell Setup

1. If you haven't already, [install Stack](https://haskell-lang.org/get-started)
	* On POSIX systems, this is usually `curl -sSL https://get.haskellstack.org/ | sh`
2. Install the `yesod` command line tool: `stack install yesod-bin --install-ghc`
3. Go to the directory where you have cloned this project and build libraries: `stack build`

## Development

Start a development server with:

```
stack exec -- yesod devel
```
or simply

```
yesod devel
```
As your code changes, your site will be automatically recompiled and redeployed to http://localhost:3000/. DELto EL translator wille be here: http://localhost:3000/parser, Int to S4 translator: http://localhost:3000/int

## Yesod

This app is built with the help of Yesod, Yesod simple web template is used/ More info about Yesod: https://www.yesodweb.com/


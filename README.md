# Now supporting this through IMS
https://github.com/IMSGlobal/ex-OR-code

This repo is being put in read-only mode now.

# ExOneroster

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Automated Tests + Coverage

100% coverage currently - will not accept PR's without automated tests added or updated.

  * MIX_ENV=test mix coveralls.html (to output test coverage)

If you are using VS Code, launch + tasks added (you will need to add your own keyboard shortcuts). Following tasks are included:
  * mix test (run all tests)
  * mix test file:linenumber (run single test on cursor)
  * mix test file (run single current file)
  * mix test file --failed (only failed tests from previous run)

## TODO

  * Update everything to camel case (spec's in pascal case)

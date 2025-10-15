Documentation — QuizMaster
==========================

Purpose
-------
QuizMaster is a small desktop quiz application written in Object Pascal (Delphi VCL). It helps users create quizzes, import quizzes from external sources (an online trivia API or an AI service), answer quizzes, and review results and statistics. The app stores quizzes and results in a local Microsoft Access (`.mdb`) database and includes manager units to encapsulate quiz creation, answering, API/AI integration, and result tracking.

What this document covers
-------------------------
- A plain-language description of what the program does and why it exists.
- How to run and interact with the program (for end users).
- A brief developer-oriented section explaining key modules and data flows.
- Troubleshooting tips and common gotchas for building or running the app.

What the program does (high level)
----------------------------------
- Create and edit quizzes: Users can define quizzes with a title, one or more questions, and multiple answers per question. Each question has a correct answer and zero or more distractors.
- Import questions from an external trivia API: The app can call the Open Trivia API to fetch question sets and convert them into internal quiz records.
- Generate and mark questions using an AI service: When configured with an API key (via the `OPEN_ROUTER_KEY` environment variable), the app can ask an AI model to generate quiz content and/or mark user answers automatically.
- Answer quizzes and view results: Users can take quizzes, submit answers, and see results. The app records results including score, accuracy, and streaks.
- Persist quizzes and results: All quizzes, questions, answers, and user results are saved to a local `database.mdb` Access file using ADO.

Who it's for
------------
- Teachers and students who want a small, local tool to create and manage quizzes.
- Developers learning Delphi VCL patterns (simple data modules, ADO, small manager classes).

How to use the program (end-user guide)
---------------------------------------
Note: This guide assumes you have a built executable and `database.mdb` accessible.

Starting the app
- Run the built executable from Windows Explorer or from within RAD Studio after building.
- If this is your first run, ensure `database.mdb` is in the same folder as the executable (or the path referenced in the data module).

Common user workflows
- Create a quiz
  1. Open the "Create" or "New Quiz" form (menu/button labeled "Create").
  2. Enter a quiz title.
  3. Add one or more questions. For each question: type the question text, add answer options and mark one as the correct answer.
  4. Save the quiz. The quiz will be stored in the local Access database.

- Edit an existing quiz
  1. Use the "Edit" screen to select a saved quiz.
  2. Modify question text or answers.
  3. Save changes.

- Import from the Open Trivia API
  1. Open the API import dialog.
  2. Specify options (number of questions, category if available, difficulty level if supported).
  3. Run the import. Imported questions are converted and saved as a new quiz.

- Generate with AI / automatic marking
  1. Set the `OPEN_ROUTER_KEY` environment variable to your API key (see README for examples).
  2. Use the AI import/generation button to create questions or use auto-marking.
  3. AI responses are parsed as JSON; model output may contain extra text. The app tries to extract a JSON block when possible.

- Answer a quiz
  1. Open the "Answer" form and select a quiz.
  2. Answer questions using the provided UI controls (radio buttons, checkboxes, or text fields depending on question type).
  3. Submit your answers. The app will compute a score, show correct/incorrect markers, and update streaks.

- View results and statistics
  1. Open the "Results" screen to see average scores, recent attempts, and streak information.
  2. Use filters where provided to inspect specific quizzes or date ranges.

Developer notes (high-level)
----------------------------
If you plan to read or modify the source code, these are the key units and their responsibilities:

- `main_p.dpr` / `main_p.dproj`
  - Application entry point and project file.

- `dbMain_u.pas`
  - Data module that centralizes database access. Manages ADO connections, tables, and helper functions (adding quizzes, questions, marking completions, and updating streaks).

- `dbTemp_u.pas`
  - Lightweight in-memory cache for category names/IDs used by the API import features.

- Model classes: `clsQuestion_u.pas`, `clsAnswer_u.pas`
  - Represent quiz domain objects such as questions and answers. Frequently passed between UI managers and DB functions.

- Manager classes
  - `clsEditQuizManager_u.pas` — Handles mapping UI controls on the Create/Edit forms to `TQuestion`/`TAnswer` objects, input validation, and bulk creation logic.
  - `clsQuizAnswerManager_u.pas` — Orchestrates presenting questions to the user, collecting answers, and computing scores.
  - `clsResultsManager_u.pas` — Aggregates and displays results and statistics.
  - `clsQuizBoxManager_u.pas` — UI helper for quiz listing and selection.

- API / AI callers
  - `clsApiQuizCaller_u.pas` — Makes HTTP GET requests to the Open Trivia API, parses returned JSON into internal quiz structures.
  - `clsAiQuizCaller_u.pas` — Sends prompts to an OpenRouter-compatible AI endpoint and attempts to extract JSON responses for quiz generation and marking. Requires `OPEN_ROUTER_KEY` environment variable.

- UI forms
  - `frmCreateQuiz_u.pas` / `frmCreateQuiz_u.dfm` — The Create quiz form.
  - `frmEditQuiz_u.pas` / `frmEditQuiz_u.dfm` — Edit existing quizzes.
  - `frmAnswerQuiz_u.pas` / `frmAnswerQuiz_u.dfm` — The Answer form.
  - `frmResults_u.pas` / `frmResults_u.dfm` — Results display.
  - `frmHome_u.pas` — Main landing / navigation form.

Data flow and ownership notes
- The database module (`dbMain_u.pas`) owns the ADO connection and the physical persistence of quiz objects.
- Model objects (`TQuestion`, `TAnswer`) are used in memory by manager classes; be mindful of object ownership when creating/destroying objects (the codebase follows standard Delphi memory ownership patterns — whoever creates an object must free it unless a clear transfer of ownership is documented).

Build, runtime, and environment notes
------------------------------------
- Win32 vs Win64 and the Access DB
  - The shipped database and code use Jet OLEDB. Jet is 32-bit only. The simplest way to run the app without changing code is to build and run as Win32 (the default for this project). See `README.md` for a clear note about this.
  - If you need a 64-bit build, either update the connection string to use the ACE OLEDB provider and install the ACE redistributable, or migrate the DB to SQLite/FireDAC.

- Indy / OpenSSL
  - When building with HTTP and TLS support (AI/API calls), ensure the correct OpenSSL DLLs are available and match the EXE bitness. For Win32 builds use the 32-bit OpenSSL DLLs.

- Secrets and API keys
  - `OPEN_ROUTER_KEY` must be set in the environment for AI features. Do not hard-code keys in source or commit them to the repo.

Troubleshooting (common issues and fixes)
----------------------------------------
- "Provider not found" when opening the DB
  - Cause: Running a 64-bit EXE using Jet OLEDB or missing provider.
  - Fix: Build the app as Win32, or switch to ACE provider and install ACE for 64-bit. Alternatively migrate the DB to SQLite.

- OpenSSL / TLS errors when calling APIs
  - Cause: Missing or incorrect OpenSSL DLLs for the chosen bitness.
  - Fix: Place matching `libssl`/`libcrypto` DLLs next to the EXE or in PATH. Use the 32-bit DLLs for Win32 builds.

- AI-generated JSON parsing fails
  - Cause: The model returned extra text (explanations, markdown) rather than a clean JSON block.
  - Fix: The callers attempt to extract a JSON block heuristically. If parsing fails, retry the request with a clearer prompt, or inspect the raw AI response for troubleshooting. Consider constraining the model's output with stricter system prompts or validating JSON with a schema.

- Corrupted or missing `database.mdb`
  - Cause: Accidental modification, wrong path, or missing file.
  - Fix: Replace `database.mdb` from the `backups` directory (if present), or restore from a known-good copy.

Where to look in the code when things go wrong
----------------------------------------------
- DB connection and queries: `dbMain_u.pas`
- Import/parsing: `clsApiQuizCaller_u.pas` and `clsAiQuizCaller_u.pas`
- UI-to-model mapping and validation: `clsEditQuizManager_u.pas`
- Answering flow and scoring: `clsQuizAnswerManager_u.pas`

QuizMaster
=========

A small Delphi (VCL) quiz application that lets users create quizzes, answer them, view results and use API/AI sources to populate quizzes. This repository contains the full source code, a sample Access database (`database.mdb`) and supporting units.

Highlights
---------
- Native Delphi VCL application (Win32/Win64 targets).
- Uses ADO / MS Jet for local storage (`database.mdb`).
- Integrates with the Open Trivia API and an OpenRouter-compatible AI service for generating and marking quiz content.
- Structured into small manager units (quiz creation, answering, results, daily quizzes, API/AI callers).

Quick status
------------
- Language: Object Pascal (Delphi)
- UI Framework: VCL
- Database: Microsoft Access (`database.mdb`) via ADO
- External dependencies: Indy (IdHTTP, IdSSLOpenSSL), OpenSSL runtime DLLs, TNetEncoding (RTL)

IMPORTANT: Build for Win32 (32-bit)
---------------------------------
This project is configured to use the Jet OLEDB provider and the supplied Access `.mdb` file. The Jet provider is 32-bit only. To avoid "Provider not found" errors or runtime failures, build and run the application targeting Win32 (32-bit) unless you intentionally update the connection string to an ACE provider or migrate the database to a different engine. Also ensure any native DLLs (OpenSSL) and Indy/OpenSSL bindings match the EXE bitness (32-bit when running Win32 builds).

Repository layout (important files)
----------------------------------
- `main_p.dpr`, `main_p.dproj` — project entry and Delphi project file.
- `dbMain_u.pas` — central data module for DB access (AddQuiz, AddQuestion, quiz completions, stats).
- `dbTemp_u.pas` — in-memory cache for categories and helpers.
- `clsQuestion_u.pas`, `clsAnswer_u.pas` — data model classes for questions and answers.
- `clsApiQuizCaller_u.pas`, `clsAiQuizCaller_u.pas` — external API and AI callers (JSON parsing included).
- `clsEditQuizManager_u.pas`, `clsCustomQuizQuestionManager_u.pas` — UI helpers for creating and editing quizzes.
- `clsQuizAnswerManager_u.pas`, `clsResultsManager_u.pas` — answering and results display logic.
- `frm*.pas/.dfm` — visual forms used by the application (Home/Create/Edit/Answer/Results).
- `database.mdb` — sample Access database used by the app. Keep a backup.
- `LICENSE` — repository license.

Prerequisites
-------------
- Embarcadero RAD Studio / Delphi compatible with the project's language level.
- Microsoft Access Database Engine / Jet OLEDB provider:
  - The project currently uses the Jet OLEDB provider string (see `dbMain_u.pas`) which typically requires a 32-bit process and the Jet engine.
  - If you need 64-bit builds, update the connection string to use the Microsoft ACE OLEDB provider and ensure the ACE runtime is installed.
- Indy components (IdHTTP, IdSSLOpenSSL) are used. Ensure Delphi's Indy is available.
- OpenSSL runtime DLLs (e.g., libssl and libcrypto) are required by IdSSLOpenSSL on Windows. Place the appropriate DLLs next to the built EXE or in PATH.

Environment variables
---------------------
- `OPEN_ROUTER_KEY` — Required for AI generation and automatic marking features that call the OpenRouter-compatible service. If this environment variable is not set, AI features will raise an error or show a message asking for the key.

  Example (PowerShell):

```powershell
# Set for current session
$env:OPEN_ROUTER_KEY = 'your_api_key_here'

# Persist for the current user (reopen shell to take effect)
setx OPEN_ROUTER_KEY "your_api_key_here"
```

How to build and run
--------------------
1. Open `main_p.dproj` in RAD Studio / Delphi.
2. Choose your target platform (Win32 is recommended if you use Jet OLEDB and the Jet/Access engine).
3. Build the project (Project -> Build) and run.

Notes for 64-bit builds
-----------------------
- Jet OLEDB is a 32-bit-only provider. For a 64-bit executable, change the connection string in `dbMain_u.pas` to use the Microsoft ACE OLEDB provider (e.g., `Provider=Microsoft.ACE.OLEDB.12.0;`) and ensure the ACE redistributable is installed.
- Alternatively, compile as Win32 and run on 32-bit, or migrate the DB to SQLite/FireDAC for full cross-platform support.

Common troubleshooting
----------------------
- "Provider not found" or DB connection errors:
  - Make sure the Jet/ACE database engine is installed and the target bitness (32/64) matches the provider.
  - Verify `database.mdb` is present next to the executable or that the path used in `dbMain_u.pas` is correct.

- OpenSSL / TLS errors when contacting external APIs:
  - Ensure the correct OpenSSL DLLs for your Indy version are available (e.g., `libcrypto-1_1-x64.dll` / `libssl-1_1-x64.dll` or their 32-bit counterparts) and match the executable bitness.

- AI or API calls failing:
  - Ensure network access is available and `OPEN_ROUTER_KEY` is set for AI features.
  - The app expects specific JSON shapes from the APIs; if APIs change, parsing may fail with a message.

Security and secrets
--------------------
- Never commit API keys or secrets to the repository. Use environment variables as shown above.
- If you need to distribute the application with AI features, instruct users to provide their own API keys.

Testing the app (quick manual tests)
-----------------------------------
- Start the app and use the Home screen to:
  - Create a custom quiz (Create -> enter title, questions) and save.
  - Open "Answer quiz" for any saved quiz and submit answers.
  - View results in the Results form — average score and streaks are persisted.

Notes about this codebase
-------------------------
- The application uses an Access `.mdb` file for simplicity. For production scenarios consider migrating to a server-based DB or SQLite for single-file local storage with better cross-platform compatibility.
- The AI integration is designed to be tolerant: when the model returns extra text (markdown fences, commentary), the code attempts to extract a JSON block. However, model output can be unpredictable; further hardening may be useful if you rely heavily on AI.

About the changes made in this branch
------------------------------------
- Non-functional documentation comments were added across several Pascal units to clarify responsibilities and explain tricky functions. No application logic was intentionally changed during these edits.

Contributing
------------
If you want to contribute:
- Open issues describing bugs or desired improvements.
- Keep edits focused; for structural or DB changes open an issue first so we can discuss migration strategy.

License
-------
See the `LICENSE` file in the repository root.

Contact
-------
If you have questions about building or running the project, include the Delphi version and whether you are building for Win32 or Win64 when reporting problems.

-----
Generated README — updated Oct 14, 2025

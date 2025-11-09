# Implementation Planning Prompt

<\!-- 
This prompt helps AI assistants create comprehensive implementation plans from GitHub issues.
It guides the AI to:
1. Gather complete context from the issue (description, comments, labels, dependencies)
2. Process any image attachments to extract visual requirements
3. Create a detailed, low-level implementation plan with specific tasks and file changes
4. Present the plan for review before making any code changes

Use this when you want a thorough analysis and planning phase before starting implementation work.
-->

I need you to gather comprehensive context about Github issue # _____ from my _____ Github repository and create a detailed implementation plan. Follow these steps:

**Step 1: Gather Issue Context**
- Use the Github CLI or REST API to retrieve all details from issue # _____, including:
    - Issue summary, description, and acceptance criteria
    - Comments and discussion threads
    - Labels, components, and issue type
    - Current status and priority
    - Any linked issues or dependencies
    - List of all attachments

**Step 2: Process Image Attachments**
- If the issue has any image attachments (screenshots, diagrams, mockups, etc.):
    - Download each image attachment to a temporary location
    - Analyze the images to extract additional context about:
        - UI/UX requirements or design specifications
        - Error messages or bug reproductions
        - Architecture diagrams or flow charts
        - Any other visual information relevant to the implementation
- If no image attachments exist, note this and proceed to the next step

**Step 3: Create Implementation Plan**
- Based on all gathered context (issue details, comments, and image analysis), create a comprehensive, low-level implementation plan that includes:
    - A bulleted list of all specific tasks needed to implement the issue
    - For each task, specify:
        - Which files will need to be created or modified
        - What architectural patterns to follow (MVVM, UseCases, Repository, etc.)
        - Any dependencies or prerequisites
        - Testing requirements (unit tests, integration tests)
    - Identify any potential risks or blockers
    - Estimate the complexity/effort for each task

**Step 5: Present the Plan**
- Create a markdown file for this plan in the current directory
- Include a summary of the issue context and any insights gained from image analysis
- Wait for me to review the file before proceeding with any code changes

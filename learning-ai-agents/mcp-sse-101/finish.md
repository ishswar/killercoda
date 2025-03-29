
<br>

### What did we just learned 

Here is a summary of the key points covered in the provided Markdown files:

- An introduction to Helm hooks - what they are and why they are useful for inserting automation logic around release events.

- Overview of a sample multi-tier voting app with microservices like vote, result, redis, db, worker. 

- Deploying the voting app using Helm charts, one for each component.

- Adding a PVC and init container to the vote app to copy files from image to persistent storage on startup.

- Defining a Helm hook to run a job that manipulates the vote app data after install/upgrade.

- The hook runs a script that changes "vs" to "or" in the index.html template.

- Exploring the hook manifest structure and how to invoke cleanup logic.

- Storing hook logs on the PVC so they persist after hook job deletion.

In summary, it demonstrates using Helm hooks to insert post-install automation and data manipulation logic into an application deployed via Helm charts. Hooks enable new deployment workflows.

Key concepts covered include hook definition, wiring hooks into charts, coordinating hooks with volumes and init containers, and hook cleanup handling.

Overall, an effective example of extending Helm releases beyond simple installs to enable powerful post-deployment automation scenarios.

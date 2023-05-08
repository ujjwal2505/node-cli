#!/usr/bin/env node
const enquirer = require("enquirer");
const gradient = require("gradient-string");
const figlet = require("figlet");
const { createSpinner } = require("nanospinner");
const path = require("path");
const { execFile, exec, spawn } = require("child_process");

// child process calling
const sleep = (ms = 2000) => new Promise((r) => setTimeout(r, ms));

const welcome = async () => {
  const msg = "DATAFORTRESS";
  figlet(msg, (err, data) => {
    console.log(gradient.pastel.multiline(data));
  });
};

async function chooseOption() {
  await sleep();
  const answer = await enquirer.select({
    name: "chooseOption",
    message: "What do you want to do?",
    choices: [
      "Transfer from on premise to AWS",
      "Transfer on premise to on premise",
    ],
  });

  if (answer === "Transfer on premise to on premise") {
    // await toPrem();
    console.log("In development");
  } else if (answer === "Transfer from on premise to AWS") {
    await toAws();
  }
}

const AWSPromptList = [
  {
    name: "username",
    type: "input",
    message: "Input the username: ",
  },
  {
    name: "remoteIP",
    type: "input",
    message: "Input the Remote IP: ",
  },
  {
    name: "priKeyLoc",
    type: "input",
    message: "Input the Private key location: ",
  },
  {
    name: "fileLoc",
    type: "input",
    message: "Enter full path of file which is to be transferred: ",
  },
];

const AWSPrompt = async () => {
  const answers = await enquirer.prompt(AWSPromptList);
  return answers;
};

const init_tranfer = (filepath, loginNameAndIp, awsPrivateKeyPath) => {
  const scriptPath = path.join(__dirname, "scripts", "transfer.sh");
  const command = `bash ${scriptPath} ${filepath} ${loginNameAndIp} ${awsPrivateKeyPath}`;

  // Execute a system command

  //   exec(command, (error, stdout, stderr) => {
  //     if (error) {
  //       console.error(`Error executing command in tranfer.sh: ${error}`);
  //       return;
  //     }
  //     console.log(`Command output in tranfer.sh: ${stdout}`);
  //   });
  let child = spawn("bash", [
    scriptPath,
    filepath,
    loginNameAndIp,
    awsPrivateKeyPath,
  ]);

  child.stdout.on("data", (data) => {
    console.log(`stdout: ${data}`);
  });

  //   child.stderr.on("data", (data) => {
  //     console.error(`stderr: ${data}`);
  //   });

  child.on("close", (code) => {
    console.log(`Exited with code ${code}`);
  });
};

async function toAws() {
  // Your code to transfer from on premise to AWS goes here

  const { username, remoteIP, priKeyLoc, fileLoc } = await AWSPrompt();
  //   let spinner = createSpinner("Initializing AWS setup").start();

  init_tranfer(fileLoc, `${username}@${remoteIP}`, priKeyLoc);

  //   spinner.success({ text: "Completed the process in AWS !\n" });
}

const delay = (ms) => new Promise((res) => setTimeout(res, ms));

// Immediately-invoked function expression (IIFE) to execute main function
(async () => {
  try {
    await welcome();
    // modules.init_setup(process.cwd.toString());
    await chooseOption();
  } catch (error) {
    console.error(error);
  }
})();

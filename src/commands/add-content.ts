import inquirer from "inquirer";
import fs from "fs-extra";
import { v4 as uuidv4 } from "uuid";
import chalk from "chalk";

export async function addContent() {
  const answers = await inquirer.prompt([
    { type: "input", name: "creatorId", message: "Creator ID:" },
    { type: "input", name: "title", message: "Content Title:" },
    { type: "input", name: "description", message: "Description (optional):" },
    { type: "input", name: "fileHash", message: "Content Hash (SHA256/IPFS CID):" }
  ]);

  const content = {
    id: uuidv4(),
    creatorId: answers.creatorId,
    title: answers.title,
    description: answers.description,
    contentHash: answers.fileHash,
    createdAt: new Date().toISOString(),
    licenses: []
  };

  await fs.ensureDir("./acpn-data");
  const filePath = `./acpn-data/content-${content.id}.json`;
  await fs.writeJson(filePath, content, { spaces: 2 });

  console.log(chalk.green("✅ Content added!"));
  console.log(chalk.blue("Content ID:"), content.id);
}

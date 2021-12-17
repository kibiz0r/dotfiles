import * as tsNode from "ts-node";
import * as path from "path";

const header = `
import * as fs from 'fs';
import * as os from 'os';
import * as path from 'path';
import * as _ from 'lodash';
import async  from 'async';
/* import * as aws  from 'aws-sdk'; */
import * as inversify from 'inversify';
import delay from 'delay';
import * as faker from 'faker';
import * as convert from 'convert-units';
import * as moment from 'moment';
import * as pem from 'pem';
import * as chrono from 'chrono-node';
import * as inflection from 'inflection';
import * as z from 'zod';
import ow from 'ow';
import "reflect-metadata";
`;

const repl = tsNode.createRepl();
const service = tsNode.create({ ...repl.evalAwarePartialHost });
repl.setService(service);

global["__dirname"] = path.dirname(repl.state.path);
global["__filename"] = path.basename(repl.state.path);
global["module"] = module;
global["exports"] = module.exports;
global["require"] = module.require.bind(module);

repl["context"] = global;

const oldEvalCode = repl.evalCode;
repl.evalCode = (code) => {
  if (!code.endsWith("\n")) {
    code += "\n";
  }
  return oldEvalCode(code);
};

for (const headerLine of header.split("\n")) {
  repl.evalCode(headerLine);
}
repl.start();

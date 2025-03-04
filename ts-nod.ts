import * as tsNode from "ts-node";
import * as path from "path";

const header = `
import * as _ from 'lodash';
import async  from 'async';
/* import * as aws  from 'aws-sdk'; */
import * as inversify from 'inversify';
import delay from 'delay';
import * as faker from 'faker';
import * as convert from 'convert-units';
import * as moment from 'moment-timezone';
import * as pem from 'pem';
import * as chrono from 'chrono-node';
import * as inflection from 'inflection';
import * as z from 'zod';
import ow from 'ow';
import "reflect-metadata";
import * as cronParser from 'cron-parser';
import * as immer from 'immer';
import * as reduxSaga from 'redux-saga';
import * as rtk from '@reduxjs/toolkit';
import * as redux from 'redux';
import * as dateFns from 'date-fns';
import * as xml from 'fast-xml-parser';
import * as Aedes from 'aedes';
import * as net from 'net';
import * as http from 'http';
import * as ws from 'websocket-stream';
import * as mobx from 'mobx';
import * as fs from 'fs';
import * as fsp from 'fs/promises';
import * as yaml from 'yaml';
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

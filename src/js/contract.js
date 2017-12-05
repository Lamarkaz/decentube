import config from "../../config.json";
import { default as Web3} from 'web3';

  // Checking if Web3 has been injected by the browser (Mist/MetaMask/Brave)
  if (typeof web3 !== 'undefined' && config.MetamaskFirst === true) {
    window.web3 = new Web3(web3.currentProvider);
  } else {
    window.web3 = new Web3(new Web3.providers.HttpProvider(config.provider));
  }
  window.Decentube = new web3.eth.Contract(config.abi, config.address); // Contract instance through RPC

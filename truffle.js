module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    // development: {
    //   host: "192.168.84.76",
    //   port: 8545,
    //   network_id: "*" // Match any network id
    // },
    development: {
      host: "192.168.12.66",
      // host: "localhost",
      port: 8545,
      // port: 9585,
      network_id: "*" // Match any network id
    },
    testing: {
      host: "127.0.0.1",
      port: 8546,
      network_id: 8546212
    }
  }
};

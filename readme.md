KP (Keep Points) is an on-chain point system. It is used to incentivize people to stake ETH before the full protocol is live.

KP essentially is a soulbound ERC20 token that streams directly to wallets that are connected to the 'faucet'.

Please set the admin (most likely the kETH contract) that gives/takes away KP to wallets along with the emission rate of KP (for example, it can be 1 KP per kETH everyday).

KP.sol is `ownable` and can arbitrarily mint more KP to desired addresses and change the `admin`. Please revoke this permission when the protocol is ready to prevent tampering with KP and making it trustless.

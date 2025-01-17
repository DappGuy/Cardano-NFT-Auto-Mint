cd ~/cardano-node

mkdir nft-payment
cd nft-payment

cardano-cli address key-gen \
--verification-key-file nftpayment.vkey \
--signing-key-file nftpayment.skey

cardano-cli address build \
--payment-verification-key-file nftpayment.vkey \
--out-file nftpayment.addr \
--mainnet

echo $(cat ./nftpayment.addr)

cd ..

mkdir nft-policy

cardano-cli address key-gen \
--verification-key-file nft-policy/nftpolicy.vkey \
--signing-key-file nft-policy/nftpolicy.skey

touch nft-policy/nftpolicy.script && echo "" > nft-policy/nftpolicy.script

echo "{" >> nft-policy/nftpolicy.script 
echo "  \"keyHash\": \"$(cardano-cli address key-hash --payment-verification-key-file nft-policy/nftpolicy.vkey)\"," >> nft-policy/nftpolicy.script 
echo "  \"type\": \"sig\"" >> nft-policy/nftpolicy.script 
echo "}" >> nft-policy/nftpolicy.script

cardano-cli transaction policyid --script-file ./nft-policy/nftpolicy.script >> nft-policy/nftpolicyID
echo $(cat nft-policy/nftpolicyID)

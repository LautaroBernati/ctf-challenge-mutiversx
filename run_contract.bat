@echo off

REM Define parameters
set WALLET_PEM=C:\proyectos-otros\challenge-sol\converted_wallet.pem
set ADDRESS_ARGUMENT=erd14nw9pukqyqu75gj0shm8upsegjft8l0awjefp877phfx74775dsq49swp3
set THIRD_BIGUINT_ARGUMENT=0x0f4240
set CONTRACT_ADDRESS=
set PROXY=https://devnet-gateway.multiversx.com 
set CHAIN_ID=D

REM Decode the address argument
for /f %%i in ('mxpy wallet bech32 --decode %ADDRESS_ARGUMENT%') do set address_argument=0x%%i

REM Deploy the contract
mxpy --verbose contract deploy %CONTRACT_ADDRESS% --recall-nonce ^
    --bytecode "C:\proyectos-otros\mx-ctf-rs-public\target\wasm32-unknown-unknown\release\ctf_bump_wasm.wasm" ^
    --pem=%WALLET_PEM% ^
    --gas-limit=6000000 ^
    --proxy=%PROXY% --chain=%CHAIN_ID% ^
    --arguments %address_argument% ^
    --send || goto :error

goto :eof

:error
echo An error occurred during deployment.
exit /b 1

FROM python

WORKDIR blockads

ADD .

ENV CONTRACT_ADDRESS
ENV CONTRACT_ABI

EXPOSE 8000

CMD sed -i 's/CONTRACT_ADDRESS/$CONTRACT_ADDRESS/g' index.html && sed -i 's/CONTRACT_ABI/$CONTRACT_ABI/g' index.html && python -m SimpleHTTPServer 8000

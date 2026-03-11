'use client';
import { useState } from 'react';
import { ethers } from 'ethers';

export default function VotingPage() {
  const [question, setQuestion] = useState('');
  const [options, setOptions] = useState(''); 

  async function handleCreate() {
    const provider = new ethers.providers.Web3Provider(window.ethereum as any);
    const signer = provider.getSigner();
    const contract = new ethers.Contract("0xd9145CCE52D386f254917e481eB44e9943F39138", ABI, signer);

    const optionsArray = options.split(',').map(o => o.trim());
    
    const tx = await contract.createPoll(question, optionsArray);
    await tx.wait();
    console.log("Poll created!");
  }

  return (
    <div className="p-10">
       <input placeholder="Question" onChange={e => setQuestion(e.target.value)} className="border p-2 block" />
       <input placeholder="Options (comma separated)" onChange={e => setOptions(e.target.value)} className="border p-2 block mt-2" />
       <button onClick={handleCreate} className="bg-black text-white p-2 mt-2">Create Poll</button>
    </div>
  );
}
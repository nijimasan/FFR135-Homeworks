function C = ClassificationError(pVal,outputs,targets)

C = 1/(2*pVal) * sum(abs(sign(outputs) - targets));

end


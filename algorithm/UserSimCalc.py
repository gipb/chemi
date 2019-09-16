import pandas as pd
import numpy as np
from sklearn.metrics.pairwise import cosine_similarity

class UserSimilarity:
    def __init__(self, dataset):
        self.dataset = dataset
    
    def cosweight(self, id_num):
        table = self.dataset
        columns = [1,2,3,4,5,6,7,8,9]
        cos_sim = cosine_similarity(table[columns])
        indices = pd.Series(range(len(table)), index = table.index).drop_duplicates()
        idx = indices[id_num]
        table['similarity'] = cos_sim[idx]
        table = table[table.index != id_num]
        table = table.sort_values(by='similarity',ascending=False)
        
        return table
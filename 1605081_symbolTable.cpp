#include<iostream>
#include<fstream>
#include<string>
#include<stdlib.h>
#include<stdio.h>
using namespace std;
FILE *logout;
FILE *tokenout;

class Symbolinfo
{
    string name;
    string type;
public:
    Symbolinfo * next;
    Symbolinfo(){
        next = 0;
    }
    void setName(string name)
    {
        this->name = name;
    }
    string getName()
    {
        return this->name;
    }
    void setType(string type)
    {
        this->type = type;
    }
    string getType()
    {
        return this->type;
    }
    ~Symbolinfo()
    {
        delete next;
    }
};

class ScopeTable
{
    int id;
    Symbolinfo **hashtable;
    int sizeofArray;
public:
    ScopeTable *parentScope;
    int getid()
    {
        return id;
    }
    ScopeTable(int length,int id)
    {
        hashtable = new Symbolinfo*[length];
        sizeofArray = length;
        this->id = id;
        for(int i =0; i < sizeofArray; i++)
        {
            hashtable[i] = 0;
        }
        parentScope = 0;
    }
    int hashfunction1(string str,int sizeofArray)
    {
        long long int key = 7;

        for(int i =0; i < str.length(); i++)
        {
            key = key*33 + str[i];
        }

        return key%sizeofArray;

    }
    bool insertItem(string name,string type)
    {
        Symbolinfo *check = this->searchItem(name);
        if(check!=0)
        {
            return false;
        }
        
        int key = hashfunction1(name,sizeofArray),count=0;
        Symbolinfo *temp = new Symbolinfo() ;
        temp->setName(name);
        temp->setType(type);

        Symbolinfo *temp2;
        temp2 = hashtable[key];
        if(temp2==0)
        {
            hashtable[key] = temp;
        }
        else
        {
            while(temp2->next!=0)
            {
                count++;
                temp2 = temp2->next;
            }
            count++;
            temp2->next = temp;
        }

        printAll();
        
        return true;
    }
    void printAll()
    {
        fprintf(logout,"\n");
        fprintf(logout,"Scopetable : \n");
        for(int i =0; i < sizeofArray; i++)
        {
            Symbolinfo *temp = hashtable[i];
            if(temp!=0)
            {
                fprintf(logout,"\n");
                fprintf(logout,"%d --> ",i);
            }
            
            while(temp!=0)
            {
                fprintf(logout," < %s : %s > ",temp->getName().c_str(),temp->getType().c_str() );
                temp = temp->next;
            } 
            
        }
        fprintf(logout,"\n");
    }
    
    bool deleteItem(string name)
    {
        int key = hashfunction1(name,sizeofArray);
        Symbolinfo *temp = hashtable[key];
        if(temp==0)
        {
            cout << "Not found" << endl;
            return false;
        }
        else
        {
            int count=0;
            if(temp->getName().compare(name)==0)
            {
                cout << "Found in scopetable # " << id << " at position " << key << " , " << count << endl;
                cout << "Deleted entry at " << key << " , " << count << " from current scopeTable" << endl;
                Symbolinfo *tmpS = hashtable[key];
                hashtable[key] = hashtable[key]->next;
                delete tmpS;
                return true;
            }
            Symbolinfo *prev;
            prev = temp;
            temp = temp->next;
            while(temp!=0)
            {
                count++;
                if(temp->getName().compare(name)==0)
                {
                    cout << "Found in scopetable # " << id << " at position " << key << " , " << count << endl;
                    cout << "Deleted entry at " << key << " , " << count << " from current scopeTable" << endl;
                    prev->next = temp->next;
                    delete temp;
                    return true;
                }
                prev = temp;
                temp = temp->next;
            }
        }
        cout << "Not found" << endl;
    }
    Symbolinfo* searchItem(string name)
    {
        int key = hashfunction1(name,sizeofArray),count=0;
        Symbolinfo *temp = hashtable[key];
        while(temp!=0)
        {
            if(temp->getName().compare(name)==0)
            {
                //cout << "Found in scopetable # " << id << " at position " << key << " , " << count << endl;
                return temp;
            }
            temp = temp->next;
            count++;
        }
        return 0;
    }
    ~ScopeTable()
    {
        
        for(int i =0; i < sizeofArray; i++)
        {
            Symbolinfo *temp = hashtable[i];
            Symbolinfo *prev = 0;
            while(temp!=0)
            {
                prev = temp;
                
                temp = temp->next;
                free(prev);
                
            }
        }
        
        delete [] hashtable;
    }
};

class SymbolTable
{
    ScopeTable *currentScope;
    int count ;
    int tableSize;
public:
    SymbolTable(int size)
    {
        currentScope = 0;
        count = 0 ;
        tableSize = size;
        ScopeTable *newScope = new ScopeTable(tableSize,count++);
        newScope->parentScope = currentScope;
        currentScope = newScope;
    }
    void enterScope()
    {
        ScopeTable *newScope = new ScopeTable(tableSize,count);
        newScope->parentScope = currentScope;
        currentScope = newScope;
        cout << "New scopetable created with id # " << count++ << endl;
    }
    void exitScope()
    {
        cout << "ScopeTable removed with id #" << currentScope->getid() << endl;
        ScopeTable *temp = currentScope;
        currentScope = currentScope->parentScope;
        delete temp;
    }
    void insertIt(string name,string type)
    {
        currentScope->insertItem(name,type);
    }
    bool removeItem(string name)
    {
        currentScope->deleteItem(name);
    }
    Symbolinfo * lookup(string name)
    {
        ScopeTable *temp;
        temp = currentScope;
        while(temp!=0)
        {
            Symbolinfo *objSearched = temp->searchItem(name);
            if(objSearched!=0)
            {
                return objSearched;
            }
            else
            {
                temp = temp->parentScope;
            }
        }
        cout << "Not found" << endl;
        return 0;

    }
    void printCurrentScopeTable()
    {
        //currentScope->printAll();
    }
    void printAllScopeTable()
    {
        ScopeTable *temp = currentScope;
        while(temp!=0)
        {
            //temp->printAll();
            temp = temp->parentScope;
            cout << endl;
        }
    }
    ~SymbolTable()
    {
        ScopeTable *temp;
        while(currentScope!=0)
        {
            temp = currentScope;
            currentScope = currentScope->parentScope;
            delete temp;
        }
    }
};

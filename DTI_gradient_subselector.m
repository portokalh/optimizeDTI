function [ gradient_file_name, subset_list, total_quality_score ] = DTI_gradient_subselector( target_gradient_table_text_file,master_gradient_table_text_file,varargin)
%DTI Gradient Subselector: Select the subset of gradient vectors from a
% larger gradient table which best approximates the target gradient table.
% If a third gradient table is specified, the output gradient will be
% constructed from it instead of master table (on index-wise basis). This
% is useful when dealing with a previously corrected gradient table.

%% Input order
%  target_table,master_table, option_1, option_2 --option order shouldn't
%  matter

%% Required inputs:
%  % target_gradient_table_text_file: The full path to the gradient table
%    which you want to emulate.
%
%  % master_gradient_table_text_file: The full path to the gradient table
%    containing all the potential matches
%% Optional inputs:
%  % corrected_gradient_table_text_file: The full path to the gradient table
%    which contains the corrected values of the master gradient table.
%
%  % match_target_sign:  If you want to visually compare target vectors and
%    their approximate matches, specify '1' to have the signs of the output
%    vectors match the target vectors regardless of their signage (default '0'). 
%

%%  What it do:
%   Load both gradient tables into matrix format
%   For each target vector:
%       Calculate dot product between vector(i) and all master vectors AND their antipodes
%       Select the minimum value between given and antipode vectors
%       Select overall minimum from all master vectors
%       Write stored gradient string to gradient_file_name
%       Add index to subset_list
%       Track quality score for target vector
%   Save gradient_file_name
%   Calculate total quality score
%   Return all values

%   Quality score:
%      Currently, it is defined as the norm2 --think Pythagorem-- of (1-max_dot_product(i))  
%


%% Set up working environment
[out_dir,original_name,ext]=fileparts(target_gradient_table_text_file);
gradient_file_name = [out_dir '/' original_name '_approximation' ext];

%%   Load both (or all three) gradient tables into matrix format

targets = double(dlmread(target_gradient_table_text_file,','));
master = double(dlmread(master_gradient_table_text_file,','));

corrected = master;
match_target_sign=0;
if ~isempty(varargin)
     for varg_num = 1:numel(varargin)
         current_v = varargin{varg_num};
         v_class = class(current_v);
         if strcmp(v_class,'char')
             corrected_gradient_table_text_file = current_v;
             corrected = double(dlmread(corrected_gradient_table_text_file,','));
         else
             match_target_sign = current_v;
         end
     end
end


num_m = length(master);

targets = targets';
master=master';
corrected = corrected';

non_zero_length = 0;
subset_list=[];
cum_qs = 0;
out_matrix = [];

%%   For each target vector:
b0_count = 0;
for t_index = 1:length(targets)
    full_t_vector = targets(:,t_index);
    t_vector = full_t_vector(1:3);
    t_tester = max(abs(t_vector));
    %Normalize
    if t_tester
        t_vector = t_vector/norm(t_vector);
        non_zero_length=non_zero_length + 1;
    else 
        b0_count = b0_count + 1;
    end
    
    current_max = 0;
    max_index = 1;
    max_m_vector =[];
    current_qs = 0;
    skip_rest = 0;
    
    
    %Calculate dot product between vector(i) and all master vectors AND their antipodes
    current_b0=0;   
    for m_index = 1:num_m
        if (~skip_rest)
            full_m_vector = master(:,m_index);
            full_output_m_vector = corrected(:,m_index);
            m_vector = full_m_vector(1:3);
            m_tester = max(abs(m_vector));
            if (~m_tester)
                current_b0 = current_b0+1;
            end
            %Normalize
            if (m_tester && t_tester)
                m_vector = m_vector/norm(m_vector);
                anti_m_vector = (-1)*m_vector;
                
                m_vec_dot = dot(t_vector,m_vector);
                anti_m_vec_dot = dot(t_vector,anti_m_vector);
  
                %Select the minimum value between given and antipode vectors
                current_dot = abs(m_vec_dot);
                
                
                
                if match_target_sign    
                    if anti_m_vec_dot > m_vec_dot
                        full_output_m_vector(1:3) = -1*full_output_m_vector(1:3);
                    end
                end
                    
                    %Select overall maximum from all master vectors
                if (current_dot > current_max)
                    current_max = current_dot;
                    max_index = m_index;
                    current_qs = (1-current_max)*(1-current_max);
                    max_m_vector = full_output_m_vector;
                end
            elseif (~m_tester && ~t_tester)
                if (b0_count == current_b0)
                    skip_rest = 1;
                end
                max_index = m_index;
                max_m_vector = full_output_m_vector;              
            end
        
        end

    end
    

    %Track quality score for target vector
    cum_qs=cum_qs+current_qs;
    
    %Add index to subset_list
    subset_list = [subset_list max_index];        
    
    %dots(t_index)=current_max % This is the dot product for the best
    %                             match for each input vector, if one is
    %                             curious.
    
    %Write stored gradient string to gradient_file_name
    out_matrix = [out_matrix; max_m_vector'];
    %dots(m_index) = current_dot;
end

%% Save gradient_file_name
dlmwrite(gradient_file_name,out_matrix)

%% Calculate total quality score

total_quality_score = (cum_qs/non_zero_length)^(1/2);

end
